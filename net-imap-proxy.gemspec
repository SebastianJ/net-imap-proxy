
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "net/imap/proxy/version"

Gem::Specification.new do |spec|
  spec.name          = "net-imap-proxy"
  spec.version       = Net::IMAP::Proxy::VERSION
  spec.authors       = ["Sebastian Johnsson"]
  spec.email         = ["sebastian.johnsson@gmail.com"]

  spec.summary       = %q{Proxy support for Ruby's Net::IMAP library.}
  spec.description   = %q{Proxy support for Ruby's Net::IMAP library.}
  spec.homepage      = "https://github.com/SebastianJ/net-imap-proxy"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_dependency 'proxifier', '~> 1.0', '>= 1.0.3'

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  
  spec.add_development_dependency 'mail', '~> 2.7', '>= 2.7.1'
end
