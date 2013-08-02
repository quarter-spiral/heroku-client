require 'cgi'
require 'json'

module Heroku
  class Client
    class App
      SIZES = {
        '1x' => 1,
        '2x' => 2
      }

      def initialize(id, connection)
        @id = id
        @connection = connection
      end

      def formation
        response = @connection.request(:get, "/apps/#{CGI.escape(@id)}/formation")
        parse_formation(response)
      end

      def scale(type, quantity, size = nil)
        options = {'quantity' => quantity}
        if size
          raise Error.new("Unknown size: #{size}!") unless SIZES[size]
          options['size'] = SIZES[size]
        end
        response = @connection.request(:patch, "/apps/#{CGI.escape(@id)}/formation/#{CGI.escape(type)}", options)
        parse_formation(response)
      end

      protected
      def parse_formation(response)
        raise Error.new("Could not retrieve formation. Status: #{response.status}") unless [200,201].include?(response.status)
        data = JSON.parse(response.body)
        Hash[data.map do |format|
          [format['type'], {
            'quantity' => format['quantity'],
            'size' => SIZES.key(format['size'])
          }]
        end]
      end
    end
  end
end