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

            connection.request :url_encoded
            connection.response :raise_error
            connection.adapter :net_http
            connection.use FaradayMiddleware::EncodeJson, content_type: "application/json"
            connection.response :detailed_logger, Rails.logger, "web-sms"
          end
        end

        def token
          Base64.encode64("#{Configuration.default.username}:#{Configuration.default.password}")
        end
      end
    end
  end
end
