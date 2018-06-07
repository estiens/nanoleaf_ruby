namespace :nanoleaf do
  desc "generates an auth token if the nanoleaf is in the right mode"
  task :generate_token, [:ip_address] do |task, args|
    nanoleaf_ip = ENV['NANOLEAF_IP_ADDRESS'] || args[:ip_address]
    api = NanoleafRuby::Api.new(ip_address: nanoleaf_ip, token: 'null')
    response = api.generate_auth_token
    puts response
  end
end
