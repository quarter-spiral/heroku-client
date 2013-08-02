require "heroku/client/version"
require "heroku/client/error"
require "heroku/client/connection"
require "heroku/client/app"

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