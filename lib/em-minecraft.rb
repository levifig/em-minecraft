$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'eventmachine'
require 'em-minecraft/packets'
require 'em-minecraft/client_packets'
require 'em-minecraft/server_packets'
require 'em-minecraft/protocol'
