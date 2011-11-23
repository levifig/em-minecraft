module EventMachine
  module Protocols
    module Minecraft
      module Packets
        module Server
          def self.server header, schema = {}
            server_packet_schemas[header] = schema
          end

          def server_packet header, values = {}
            Packets.create_packet Server.server_packet_schemas[header], header, values
          end

          def parse_server_packet data
            Packets.parse_packet Server.server_packet_schemas, data
          end


          def self.server_packet_schemas
            @@server_schemas ||= {}
          end    

          server 0x00, :keepalive_id => :int
          server 0x01, :entity_id => :int, :unknown => :string16, :map_seed => :long, :server_mode => :int, :dimension => :byte, :difficulty => :byte, :world_height => :byte, :max_players => :byte
          server 0x02, :server_id => :string16
          server 0x04, :time => :long
          server 0x05, :entity_id => :int, :slot => :short, :item_id => :short, :unknown => :short
          server 0x06, :x => :int, :y => :int, :z => :int
          server 0x08, :health => :short, :food => :short, :food_saturation => :float
          server 0x09, :world => :byte, :difficulty => :byte, :creative_mode => :byte, :world_height => :short, :map_seed => :long
          server 0x12, :eid => :int, :animate => :byte
          server 0x14, :eid => :int, :player_name => :string16, :x => :int, :y => :int, :z => :int, :rotation => :byte, :pitch => :byte, :current_item => :short
          server 0x15, :eid => :int, :item => :short, :count => :byte, :damage => :short, :x => :int, :y => :int, :z => :int, :rotation => :byte, :pitch => :byte, :roll => :byte
          server 0x16, :eid => :int, :eid => :int
          server 0x17, :eid => :int, :type => :byte, :x => :int, :y => :int, :z => :int, :eid => :int, :unknown1 => :short, :unknown2 => :short, :unknown3 => :short
          server 0x18, :eid => :int, :type => :byte, :x => :int, :y => :int, :z => :int, :yaw => :byte, :pitch => :byte, :data_stream => :metadata
          server 0x19, :eid => :int, :title => :string16, :x => :int, :y => :int, :z => :int, :direction => :int
          server 0x1A, :eid => :int, :x => :int, :y => :int, :z => :int, :count => :short
          server 0x1C, :eid => :int, :x => :short, :y => :short, :z => :short
          server 0x1D, :eid => :int
          server 0x1E, :eid => :int
          server 0x1F, :eid => :int, :dx => :byte, :dy => :byte, :dz => :byte
          server 0x20, :eid => :int, :yaw => :byte, :pitch => :byte
          server 0x21, :eid => :int, :dx => :byte, :dy => :byte, :dz => :byte, :yaw => :byte, :pitch => :byte
          server 0x22, :eid => :int, :x => :int, :y => :int, :z => :int, :yaw => :byte, :pitch => :byte
          server 0x26, :eid => :int, :status => :byte
          server 0x27, :eid => :int, :vehicle_id => :int
          server 0x28, :eid => :int, :metadata => :metadata
          server 0x29, :eid => :int, :effect_id => :byte, :amplifier => :byte, :duration => :short
          server 0x2B, :xp => :byte, :level => :byte, :total_xp => :short
          server 0x32, :x => :int, :z => :int, :mode => :bool, :x => :int, :y => :int, :z => :int, :yaw => :byte, :pitch => :byte, :metadata => :metadata
          server 0x33, :x => :int, :y => :short, :z => :int, :size_x => :byte, :size_y => :byte, :size_z => :byte, :compressed_size => :int, :compressed_data => :byte_array
          server 0x34, :chunk_x => :int, :chunk_z => :int, :array_size => :short, :coord_array => :short_array, :type_array => :byte_array, :metadata_array => :byte_array
          server 0x35, :x => :int, :y => :byte, :z => :int, :block_type => :byte, :block_metadata => :byte
          server 0x36, :x => :int, :y => :short, :z => :int, :byte1 => :byte, :byte2 => :byte
          server 0x3C, :x => :double, :y => :double, :z => :double, :unknown => :float, :record_count => :int, :x => :byte, :y => :byte, :z => :byte
          server 0x3D, :effect_id => :int, :x => :int, :y => :byte, :z => :int, :sound_data => :int
          server 0x46, :reason => :byte, :game_mode => :byte
          server 0x47, :eid => :int, :unknown => :bool, :x => :int, :y => :int, :z => :int
          server 0x64, :window_id => :byte, :type => :byte, :title => :string16, :slots => :byte
          server 0x65, :window_id => :byte
          server 0x67, :window_id => :byte, :slot => :short, :item_id => :short, :item_count => :byte, :item_uses => :short
          server 0x68, :window_id => :byte, :payload => :inventory_payload
          server 0x69, :window_id => :byte, :progress_bar => :short, :value => :short
          server 0x6A, :window_id => :byte, :action_number => :short, :accepted => :bool

          server 0xFF, :reason => :string16
        end
      end
    end
  end
end