# Vidyo

Gem for interacting with a Vidyo instance web service.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vidyo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vidyo

## Usage

#### Initialize client

Admin:
```ruby
Vidyo::Admin.configure do |v|
  v.instance_url = 'https://your_vidyo_tenant_instance.com'
  v.admin_username = 'username'
  v.admin_password = 'password'
  v.extension_base = 'your tenant extension base (ex. 007)'
  v.app_user_name = 'your apps vidyo username'
end
```

#### Creating a room:
```ruby
new_room = Vidyo::Admin.create_room(name: 'red-room')
```

#### Retrieving a room
By `id`:
```ruby
room = Vidyo::Admin.get_room_by_id(id: id) # => Vidyo::Room instance, or raise error
```

By `extension`:
```ruby
room = Vidyo::Admin.get_room_by_extension(extension: extension) # => Vidyo::Room instance, or nil
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/vidyo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
