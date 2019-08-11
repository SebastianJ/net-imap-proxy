# Net::IMAP::Proxy

Proxy support for Ruby's NET::IMAP library.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'net-imap-proxy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install net-imap-proxy

## Usage

The recommended way to use this gem is to use the [Mail gem](https://github.com/mikel/mail) and the provided [retriever method](lib/net/imap/proxy/retriever_method.rb):

```ruby
Mail.defaults do                      
  retriever_method ::Net::IMAP::Proxy::RetrieverMethod,
    address:       'imap.gmail.com',
    port:          993,
    user_name:     'username@gmail.com',
    password:      'somePassw0rd',
    enable_ssl:    true,
    proxy_address: 'http://proxy.domain.com',
    proxy_port:    8080
end

Mail.find(mailbox: "Inbox", order: :desc, count: :all)&.each do |email|
  puts "From: #{email.from&.first&.strip}. Subject: #{email.subject}"
end
```

If you want to use the gem without the [Mail gem](https://github.com/mikel/mail), instantiate an instance of the `Proxy` class and use it to make IMAP requests:

```ruby
address         =   'imap.gmail.com'
port            =   993
proxy_address   =   'http://proxy.domain.com' # Authentication is also supported, e.g. http://user:password@proxy.domain.com
proxy_port      =   8080

proxy           =   Net::IMAP::Proxy.new(address, port, proxy_address, proxy_port, true, nil, false) # true, nil, false = enable ssl, without specifying certs and disable ssl verification
proxy.login('username@gmail.com', 'somePassw0rd')
proxy.select("INBOX")
pp proxy.search(["ALL"])
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SebastianJ/net-imap-proxy. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Net::IMAP::Proxy project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/SebastianJ/net-imap-proxy/blob/master/CODE_OF_CONDUCT.md).
