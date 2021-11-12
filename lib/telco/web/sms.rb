# frozen_string_literal: true

require "faraday"
require "faraday_middleware"
require "faraday/detailed_logger"

require_relative "sms/version"
require_relative "sms/configuration"
require_relative "sms/simple_sms"
require_relative "sms/sms_dispatcher"

module Telco
  module Web
    module Sms
      class Error < StandardError; end

      def self.configure
        if block_given?
          yield(Configuration.default)
        else
          Configuration.default
        end
      end

      # Test => true: The transmission is only simulated, no SMS is sent.
      # Test => false (default): No simulation is done. The SMS is sent via the SMS Gateway.
      def self.send_text(message:, recipient:, test: false)
        SimpleSms.new(message: message, recipient: recipient, test: test).call
      end
    end
  end
end
