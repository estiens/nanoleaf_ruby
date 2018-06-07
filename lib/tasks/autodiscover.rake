require 'ssdp'

namespace :nanoleaf do
  desc "tries to find your nanoleaf"
  task :autodiscover do |task|
    finder = SSDP::Consumer.new(timeout: 30)
    result = finder.search(broadcast: '239.255.255.250', port: 1900, service: 'nanoleaf_aurora:light')
    puts result
  end
end
