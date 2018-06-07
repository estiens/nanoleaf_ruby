# lib/railtie.rb
require 'nanoleaf_ruby'
require 'rails'

module NanoleafRuby
  class Railtie < Rails::Railtie
    railtie_name :nanoleaf_ruby

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |f| load f }
    end
  end
end
