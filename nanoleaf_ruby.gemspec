lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nanoleaf_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'nanoleaf_ruby'
  spec.version       = NanoleafRuby::VERSION
  spec.authors       = ['Eric Stiens']
  spec.email         = ['estiens@gmail.com']

  spec.summary       = 'This gem provides a ruby wrappy for the Nanoleaf Open Api'
  spec.homepage      = 'https://www.github.com/estiens/nanoleaf_ruby'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'bin'
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.3.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 3.4'
  spec.add_dependency 'chroma', '~> 0.2'
  spec.add_dependency 'httparty', '~> 0.15'
  spec.add_dependency 'pry', '~> 0.11'
  spec.add_dependency 'ssdp', '~> 1.1'
end
