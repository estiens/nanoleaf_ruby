require 'ssdp'

namespace :nanoleaf do
  desc 'tries to find your nanoleaf'
  task :autodiscover do |_task|
    finder = SSDP::Consumer.new(timeout: 30)
    broadcast = '239.255.255.250'
    port = 1900
    service = 'nanoleaf_aurora:light'
    result = finder.search(broadcast: broadcast, port: port, service: service)
    puts result
  end
end
