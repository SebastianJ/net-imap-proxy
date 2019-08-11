require 'net/imap'
require 'proxifier'

module Net
  class IMAP
    class Proxy < IMAP
      autoload :RetrieverMethod, 'net/imap/proxy/retriever_method'

      attr_reader :proxy_address, :proxy_port

      def initialize(address, port, proxy_address = nil, proxy_port = nil, use_ssl = false, certs = nil, verify = false)
        @proxy_address  =   proxy_address
        @proxy_port     =   proxy_port
        
        super(address, port, use_ssl, certs, verify)
      end

      private
        def tcp_socket(address, port)
          Proxifier::Proxy("#{proxy_address}:#{proxy_port}").open(address, port)
        end
    end
  end
end
