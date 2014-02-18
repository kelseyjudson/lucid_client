$: << "#{File.dirname __FILE__}/lib"

require 'lucid_client/version'

Gem::Specification.new do |s|

  s.name                   = 'lucid_client'
  s.summary                = 'Extensible API client interfaces.'
  s.description            = 'Foundation for consistent and extensible RESTful API client interfaces.'
  s.license                = 'MIT'

  s.version                = LucidClient::VERSION

  s.author                 = 'Kelsey Judson'
  s.email                  = 'kelsey@luciddesign.co.nz'
  s.homepage               = 'http://github.com/luciddesign/lucid_client'

  s.files                  = %w{ README.md LICENSE lib/lucid_client.rb } +
                             Dir.glob( 'lib/lucid_client/**/*' )

  s.platform               = Gem::Platform::RUBY
  s.has_rdoc               = false

  s.required_ruby_version  = '>= 2.0.0'
  s.add_runtime_dependency   'faraday',     '~> 0.8.0'
  s.add_runtime_dependency   'excon',       '~> 0.31.0'
  s.add_runtime_dependency   'lucid_async', '~> 0.0.0'

end
