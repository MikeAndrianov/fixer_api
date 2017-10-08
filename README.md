# FixerApi
Gem for fetching data from http://fixer.io/

## Usage
```ruby
  FixerApi::Client.get_rates_for_day(Date.today)
  FixerApi::Client.get_rates_for_period(Date.today, Date.today + 1.week)
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'fixer_api'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install fixer_api
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
