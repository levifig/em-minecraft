module EventMachine
  module Protocols
    module Minecraft
      module Packets
        # these are the originators. ie. client sent a client packet, server sent a server packet
        module Client
          def self.client header, schema = {}
            client_packet_schemas[header] = schema
          end

          def client_packet header, values = {}
            Packets.create_packet Client.client_packet_schemas[header], header, values
          end

          def parse_client_packet data
            Packets.parse_packet Client.client_packet_schemas, data
          end

          def self.client_packet_schemas
            @@client_schemas ||= {}
          end

          client 0x00, :keepalive_id => :int
          client 0x01, :protocol_version => :int, :username => :string, 
                       :unused1 => :long, :unused2 => :int, :unused3 => :byte, :unused4 => :byte, :unused5 => :byte, :unused6 => :byte
          client 0x02, :username => :string
          client 0x07, :user => :int, :target => :int, :left_click => :bool
          client 0x09, :world => :byte, :difficulty => :byte, :creative_mode => :byte, :world_height => :short, :map_seed => :long
          client 0x0A, :on_ground => :bool
          client 0x0B, :x => :double, :y => :double, :stance => :double, :z => :double, :on_ground => :bool
          client 0x0C, :yaw => :float, :pitch => :float, :on_ground => :bool
          client 0x0D, :x => :double, :y => :double, :stance => :double, :z => :double, :yaw => :float, :pitch => :float, :on_ground => :bool
          client 0x0E, :status => :byte, :x => :int, :y => :byte, :z => :int, :face => :byte
          client 0x0F, :x => :int, :y => :byte, :z => :int, :direction => :byte, :item_id => :short, :amount => :byte, :damage => :short
          client 0x10, :slot_id => :short
          client 0x13, :eid => :int, :action_id => :byte
          client 0xFE

        end
      end
    end
  end
end