module Socky
  module Server
    class Connection
      include Misc

      attr_accessor :id, :application

      # initialize new connection
      # @param [Socky::Server::WebSocket] socket websocket connection
      # @param [String] app_name connection application name
      def initialize(socket, app_name)
        @socket = socket
        @application = Application.find(app_name)

        unless @application.nil?
          @id = self.generate_id
          @application.add_connection(self)
          @application.webhook_handler.trigger('client_connected', { :connection_id => @id })
        end

        self.send_data(initialization_status)
        @socket.close_websocket if @application.nil?
      end

      # return info about connection initialization
      # if successfull then it will return hash with connection id
      # otherwise it will return reson why connecton has failed
      def initialization_status
        if @application && @id
          { 'event' => 'socky:connection:established', 'connection_id' => @id }
        else
          { 'event' => 'socky:connection:error', 'reason' => 'refused' }
        end
      end

      # list of channels connection is subscribed to
      def channels
        @channels ||= {}
      end

      # send data to connection
      # @param [String] data data to send
      def send_data(data)
        @socket.send_data(data)
      end

      # remove connection from application
      def destroy
        log('connection closing', @id)
        if @application
            @application.webhook_handler.group do |handler|
              self.channels.values.each do |channel|
                channel.remove_subscriber(self)
              end
              handler.trigger('client_disconnected', { :connection_id => @id })
          end
          @application.remove_connection(self)
          @application = nil
        else
          self.channels.values.each do |channel|
            channel.remove_subscriber(self)
          end
        end
      end

      # generate new id
      # @return [String] connection id
      def generate_id
        @id = Time.now.to_f.to_s.gsub('.', '')
      end

    end
  end
end
