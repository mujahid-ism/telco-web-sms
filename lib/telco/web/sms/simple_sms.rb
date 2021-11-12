# frozen_string_literal: true

module Telco
  module Web
    module Sms
      class SimpleSms
        class InvalidUsernameOrPassword < StandardError; end

        class WbSmsApiException < StandardError; end

        class AuthorizationFailedException < StandardError
          def message
            "Invalid Credentials. Inactive account or customer."
          end
        end

        attr_accessor :message, :recipient, :test

        def initialize(message:, recipient:, test:)
          @message = message
          @recipient = recipient
          @test = test
        end

        def call
          response = SmsDispatcher.new(params: params).call

          case response.status
          when 200 then process_response(response.body)
          when 401 then raise InvalidUsernameOrPassword
          else response.body
          end
        end

        private

        def params
          {
            test: test,
            messageContent: message,
            recipientAddressList: recipient
          }
        end

        def process_response(response)
          status_code, message = response_formatter(response)

          case status_code
          when "2000", "2001" then message
          when "4001" then raise AuthorizationFailedException
          else raise WbSmsApiException, "STATUS CODE: #{status_code}. response: #{message}"
          end
        end

        def response_formatter(response)
          CGI.unescape(response).gsub(/(statusCode=)|(statusMessage=)/, "").split("&")
        end
      end
    end
  end
end
