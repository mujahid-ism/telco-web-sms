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
          response
        rescue Faraday::ClientError, Faraday::ConnectionFailed => e
          Rollbar.error(error, params: params) if defined?(Rollbar)
          OpenStruct.new(status: 500, body: e)
        end

        private

        def response
          Faraday.post("#{Configuration.default.web_sms_url}/rest/smsmessaging/simple") do |req|
            req.headers["Content-Type"] = "application/json"
            req.headers["Authorization"] = "Basic #{token}"
            req.params = params
          end
        end

        def token
          Base64.encode64("#{Configuration.default.username}:#{Configuration.default.password}")
        end
      end
    end
  end
end
