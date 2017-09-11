lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'emoji-regex/version'

Gem::Specification.new do |spec|
  spec.name          = 'emoji-regex'
  spec.version       = EmojiRegex::VERSION
  spec.authors       = ['Satoshi Ohmori']
  spec.email         = ['sachin21dev@gmail.com']

  spec.summary       = 'Make regex for latest unicode emoji.'
  spec.description   = 'Make regex for latest unicode emoji from http://www.unicode.org/Public/emoji/6.0/emoji-data.txt'
  spec.homepage      = 'https://github.com/sachin21/ruby-emoji-regex'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16.a'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop'
end
