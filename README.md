# Redis::Renew

Attempts to solve the problem of cache keys that are accessed being extended by a known value each time it is accessed.
This helps by keeping frequently accessed cache keys in the redis cache without having to store the key again.

## Installation

Add this line to your application's Gemfile:

    gem 'redis-renew'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redis-renew

## Usage
With Rails

```ruby
  # application.rb

  module Appthing
    class Application < ::Rails::Application
      # setup Rails.cache to be redis_renew
      # and set the renewal expiry to be 30 seconds
      # with each access the expiry is extended 30 seconds
      config.cache_store = :redis_renew, config.redis_connections['cache'], { :renew_expires_in => 30.seconds }
    end
  end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
