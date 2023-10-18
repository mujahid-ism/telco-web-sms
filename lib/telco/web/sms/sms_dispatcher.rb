# frozen_string_literal: true

module Telco
  module Web
    module Sms
      class SmsDispatcher
        attr_accessor :params

        def initialize(params:)
          @params = params
        end

        def call
          client.post("rest/smsmessaging/simple") do |request|
            request.headers["Authorization"] = "Basic #{token}"
            request.params = params
          end
        rescue Faraday::ClientError, Faraday::ConnectionFailed => e
          Rollbar.error(error, params: params) if defined?(Rollbar)
          OpenStruct.new(status: 500, body: e)
        end

        private

        def client
          Faraday.new(Configuration.default.web_sms_url) do |connection|
            # connection.adapter Faraday::Request::UrlEncoded
            # connection.adapter Faraday::Response::RaiseError
            # connection.adapter Faraday::Adapter::NetHttp
            # connection.response :detailed_logger, Rails.logger, "web-sms"
            # connection.request :json, content_type: "application/json"

            connection.use Faraday::Request::UrlEncoded # To encode the request as URL-encoded form data
            connection.use Faraday::Response::RaiseError # To raise exceptions on HTTP error responses
            connection.use Faraday::Adapter::NetHttp # To use the Net::HTTP adapter for making HTTP requests

            # If you want to log the requests and responses, you can define a middleware for it
            connection.response :logger, Rails.logger, headers: true, bodies: true

            connection.request :json # To send requests as JSON
            connection.headers["Content-Type"] = "application/json" # Set the content type header for JSON

            # Add any additional middlewares or configurations you need here.
          end
        end

        def token
          Base64.encode64("#{Configuration.default.username}:#{Configuration.default.password}")
        end
      end
    end
  end
end
