# ElegantMoney

Elegant and simple implementation to handle money in different currencies.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'elegant_money'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elegant_money

## Usage

```ruby
# Configure:
ElegantMoney.configure do |config|
  config.default_currency = "EUR"
  config.conversions = {
    "USD" => 1.22,
    # ...
  }
end

# Instantiate and manipulate:
twenty_eur = ElegantMoney.new(20, "EUR")
twenty_eur * 2  # => 40.00 EUR
twenty_eur / 2  # => 10.00 EUR
twenty_eur + 10 # => 30.00 EUR
twenty_eur + ElegantMoney.new(30, "EUR") # => 50.00 EUR

# Convert:
twenty_eur.convert_to("USD") # => 22.20 USD
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nicoayala/elegant_money. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ElegantMoney project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nicoayala/elegant_money/blob/master/CODE_OF_CONDUCT.md).
