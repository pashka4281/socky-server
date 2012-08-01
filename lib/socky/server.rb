require 'rubygems'
require 'json'
require 'rack/websocket'
require 'socky/authenticator'
require 'em-http'

# Socky is a WebSocket server and client for Ruby
# @author Bernard "Imanel" Potocki
# @see http://github.com/socky/socky-server-ruby main repository
module Socky
  module Server
    ROOT = File.expand_path(File.dirname(__FILE__))

    autoload :Application,     "#{ROOT}/server/application"
    autoload :Channel,         "#{ROOT}/server/channel"
    autoload :Config,          "#{ROOT}/server/config"
    autoload :Connection,      "#{ROOT}/server/connection"
    autoload :HTTP,            "#{ROOT}/server/http"
    autoload :Logger,          "#{ROOT}/server/logger"
    autoload :Message,         "#{ROOT}/server/message"
    autoload :Misc,            "#{ROOT}/server/misc"
    autoload :WebSocket,       "#{ROOT}/server/websocket"
    autoload :CachedJsonHash,  "#{ROOT}/server/cached_json_hash"
    autoload :WebhookHandler,  "#{ROOT}/server/webhook_handler"
  end
end
