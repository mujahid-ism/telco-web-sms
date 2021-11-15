# Telco::Web::Sms

Sends SMS using the Web SMS service (leading premium provider of mobile messaging services in the German-speaking area).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'telco-web-sms', source: 'https://gems.selise.tech'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install telco-web-sms

## Usage

- Create an initializer called, `telco_web_sms.rb` and define this format
```ruby
Telco::Web::Sms.configure do |config|
  config.username = 'unknown'
  config.password = '*******'
  config.web_sms_url = 'https://api.websms.com/rest/'
end
```
- Kindly ensure that the secrets are passed from encrypted credentials and not hardcoded anywhere in your source.
- Once you have defined this, you can then use the the gem to send simple sms this way.
```ruby
Telco::Web::Sms.send_text(message: 'Hello World', recipient: '97517712345', test: true)
# test => true: The transmission is only simulated, no SMS is sent.
# test => false (default): No simulation is done. The SMS is sent via the SMS Gateway.
```

## Projects using telco-web-sms

For reference(when you want to see how existing applications are using this gem)
- [ew-buchs](https://bitbucket.org/selise07/ew-buchs/src)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/telco-web-sms. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/telco-web-sms/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Telco::Web::Sms project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/telco-web-sms/blob/master/CODE_OF_CONDUCT.md).
