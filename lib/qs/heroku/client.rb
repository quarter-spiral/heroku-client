require "qs/heroku/client/version"
require "qs/heroku/client/error"
require "qs/heroku/client/connection"
require "qs/heroku/client/app"

module Qs
  module Heroku
    class Client
      def initialize(email, token)
        @connection = Connection.new(email, token)
      end

      def app(id)
        App.new(id, @connection)
      end
    end
  end
end