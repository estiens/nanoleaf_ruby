require 'rake'

path = File.dirname(__FILE__)
tasks = Dir.glob("#{path}/*.rake")
tasks.each { |file| load file }
