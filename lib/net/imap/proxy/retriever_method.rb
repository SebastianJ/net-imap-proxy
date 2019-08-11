require 'net/imap'

begin
  require 'mail'
rescue LoadError
  puts 'The mail gem is required to use the DeliveryMethod class.'
end

module Net
  class IMAP
    class Proxy < IMAP
      # for use with the mail gem
      class RetrieverMethod < ::Mail::IMAP
        private
        
        # adapted from
        # https://github.com/mikel/mail/blob/master/lib/mail/network/retriever_methods/imap.rb#L160
        def start(config=Mail::Configuration.instance, &block)
          raise ArgumentError.new("Mail::Retrievable#imap_start takes a block") unless block_given?

          if settings[:enable_starttls] && settings[:enable_ssl]
            raise ArgumentError, ":enable_starttls and :enable_ssl are mutually exclusive. Set :enable_ssl if you're on an IMAPS connection. Set :enable_starttls if you're on an IMAP connection and using STARTTLS for secure TLS upgrade."
          end
          
          init_params = [
            settings[:address], settings[:port],
            settings[:proxy_address], settings[:proxy_port],
            settings[:enable_ssl], nil, false
          ]

          imap = Net::IMAP::Proxy.new(*init_params)
          imap.starttls if settings[:enable_starttls]

          if settings[:authentication].nil?
            imap.login(settings[:user_name], settings[:password])
          else
            # Note that Net::IMAP#authenticate('LOGIN', ...) is not equal with Net::IMAP#login(...)!
            # (see also http://www.ensta.fr/~diam/ruby/online/ruby-doc-stdlib/libdoc/net/imap/rdoc/classes/Net/IMAP.html#M000718)
            imap.authenticate(settings[:authentication], settings[:user_name], settings[:password])
          end

          yield imap
        ensure
          if defined?(imap) && imap && !imap.disconnected?
            imap.disconnect
          end
        end

      end
    end
  end
end
