require 'json'
require 'cgi'
require 'faraday'

module Heroku
  class Client
    class Connection
      API_BASE = 'https://api.heroku.com/'

      def initialize(email, token)
        @email = email
        @token = token

        @conn = Faraday.new(:url => API_BASE) do |faraday|
          faraday.adapter  Faraday.default_adapter
          faraday.basic_auth(email, token)
        end
      end

      def request(method, path, options = nil)
        body = nil
        if options
          case method.to_s.downcase
          when 'post', 'put', 'patch'
            body = JSON.dump(options)
          else
            path += '?'
            path += options.map {|k,v| "#{CGI.escape(k)}=#{CGI.escape(v)}"}.map("&")
          end
        end

        @conn.send(method) do |req|
          req.url path
          req.headers['Content-Type'] = 'application/json'
          req.headers['Accept'] = 'application/vnd.heroku+json; version=3'
          req.body = body if body
        end
      end
    end
  end
end