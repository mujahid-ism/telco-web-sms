# frozen_string_literal: true

require_relative "lib/telco/web/sms/version"

Gem::Specification.new do |spec|
  spec.name          = "telco-web-sms"
  spec.version       = Telco::Web::Sms::VERSION
  spec.authors       = ["Prakash Sanyasi"]
  spec.email         = ["ps@selise.ch"]

  spec.summary       = "SDK for Web SMS"
  spec.description   = "Send sms using web sms services"
  spec.homepage      = "https://telecom.selise.ch/"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7")

  spec.metadata["allowed_push_host"] = "https://gems.selise.tech"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://bitbucket.org/selise07/telco-web-sms"
  spec.metadata["changelog_uri"] = "https://bitbucket.org/selise07/telco-web-sms/src/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.9"
  spec.add_dependency "faraday-detailed_logger", "~> 2.2.0"
  spec.add_dependency "faraday_middleware", "~> 0.9"
  spec.metadata["rubygems_mfa_required"] = "true"
end
