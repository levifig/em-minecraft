module EventMachine
  module Protocols
    module Minecraft
      module Packets
        def self.hex num
          "0x%02X" % num
        end
    
        def self.easy_fields
          { byte:[1, "C"], short:[2, "n"], int:[4, "N"], long:[8, "Q"], float:[4, "g"], double:[8, "G"] }
        end

        def self.pack_field type, value
          byte_size, code = easy_fields[type]
          if code
            [value].pack code
          else
            case type
            when :string8
              [value.length, value.encode('UTF-8')].pack("na*")
            when :string16
              [value.length, value.encode('UTF-16BE')].pack("na*")
            when :bool
              [value ? 0 : 1].pack("C")
            else
              raise "Unknown field type #{type}"
            end
          end
        end

        def self.read_field type, packet, index
          byte_size, code = easy_fields[type]
          if code
            [packet[index..(index + byte_size)].unpack(code)[0], byte_size]
          else
            case type
            when :string8
              str_char_length, bytes_read = read_field :short, packet, index; index += bytes_read
              str_byte_length = (str_char_length)
              raw = packet[index..(index + str_byte_length)]
              value = raw.force_encoding('UTF-8').encode('UTF-8')
              [value, 2 + str_byte_length]
            when :string16
              str_char_length, bytes_read = read_field :short, packet, index; index += bytes_read
              str_byte_length = (str_char_length * 2)
              raw = packet[index..(index + str_byte_length - 1)]
              value = raw.force_encoding('UTF-16BE').encode('UTF-8')
      
              [value, 2 + str_byte_length]
            when :bool
              value, bytes_read = read_field(:byte, packet, index); index += bytes_read
              [value == 1, bytes_read]
            when :metadata
              total_bytes_read = 0
              begin
                value, bytes_read = read_field(:byte, packet, index); index += bytes_read
                total_bytes_read += bytes_read
              end while value != 0x7f
              ["...", total_bytes_read]
            when :inventory_payload
              count, bytes_read = read_field :short, packet, index; index += bytes_read
              count.times { 
                item_id, bytes_read = read_field :short, packet, index; index += bytes_read 
                if item_id != -1
                  count, bytes_read = read_field :byte, packet, index; index += bytes_read
                  count, bytes_read = read_field :short, packet, index; index += bytes_read
                end
              }
              "..."
            else
              raise "Unknown field type #{type}"
            end
          end
        end

        def self.create_packet schema, header, values
          data = pack_field(:byte, header)
          schema.each{|name, type| 
            raise "no value provided for #{name}" unless values[name]
            data << pack_field(type, values[name]) 
          }
          data
        end

        def self.parse_packet schemas, packet
          # null if packet not long enough otherwise the parsed info plus the rest of the packet
          i = 0
          header, bytes_read = read_field :byte, packet, i; i += bytes_read
  
          schema = schemas[header]
  
          raise "Unknown packet:#{hex(header)}" unless schema

          body = schema.inject({}) do |hash, (name, type)|
            value, bytes_read = read_field type, packet, i; i += bytes_read
            hash[name] = value
            hash
          end

          [header, body, packet[0...i], packet[i..-1]]
        end
      end
    end
  end
end