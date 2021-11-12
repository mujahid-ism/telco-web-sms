# frozen_string_literal: true

module Telco
  module Web
    module Sms
      class Configuration
        attr_accessor(
          :username,
          :password,
          :web_sms_url
        )

        @default = Configuration.new

        def initialize
          self.username = nil
          self.password = nil
          self.web_sms_url = "https://api.websms.com/rest/"
        end

        class << self
          attr_reader :default
        end
      end
    end
  end
end
