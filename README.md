# Nanoleaf Ruby
[![Build Status](https://travis-ci.org/estiens/nanoleaf_ruby.svg?branch=master)](https://travis-ci.org/estiens/nanoleaf_ruby)

This gem is a wrapper around the Nanoleaf Open API (http://forum.nanoleaf.me/docs/openapi). It provides a wrapper around all the main API functions and also adds some advanced color commands so you can set the color of the tiles by named colors, hex values or rgb values. It is a work in progress and will be kept up to date with the Open API.

Rhythm commands and the ability to upload animations will be added shortly.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nanoleaf_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nanoleaf_ruby

## Version

Gem version 1.0.x is up to date with Nanoleaf Open API v1 (2.2.0)

## Usage

### Initialize API and call it

```ruby
require 'nanoleaf_ruby'

api = NanoleafRuby::Api.new(ip_address: 191.161.1.1:16021, token: 'foobar')

api.brightness_up
```

Note that you can initialize the api client with the IP address and token or you can include them in your env by setting `ENV['NANOLEAF_API_TOKEN']` and `ENV['NANOLEAF_IP_ADDRESS']` and it will be pulled in automatically.

### Method Responses

Most successful PUT responses from the Open API come back as 204.

Method responses from the API client will always be a ruby hash and look something like

```ruby
{:data=>{},
 :success=>true,
 :code=>204,
 :raw=>{:body=>nil, :params=>{:brightness=>{:value=>10, :duration=>10}}}}
 ```

If a method sends back a JSON object, you'll get it under `[:data]` (for example, `#effect_list` sends back an array of effect titles). You'll also always have access to the original response under `[:raw][:body]` and be able to inspect the params sent to the Open API under `[:raw][:params]`. If `[:success]` is false there will be an error message included as well.

### Methods

#### info
`api.info` returns all the info from your panels

#### power on/off
`api.on` turns the Nanoleaf panel on

`api.off` turns the Nanoleaf panel off

`api.toggle` toggles the current power status of the Nanoleaf panel

#### color mode
`api.color_mode` returns the current color mode

#### identify
`api.identify` flashes your panel

#### brightness
`api.set_brightness(value, duration = nil)` sets the brightness of the panel. When passed a second argument it will transition to that brightness over that number of seconds.

`api.brightness_increment(increment = 1)` allows you to pass a positive or negative value to increment the current brightness

`api.brightness_up(increment = 1)` pass a number to increase the brightness by that amount, defaults to 1 without an argument

`api.brightness_down(increment = 1)` pass a number to decrease the brightness by that amount, defaults to 1 without an argument

`api.get_brightness` gets the current brightness level of the panel

#### hue
`api.set_hue(value)` sets the hue of the panel.

`api.hue_increment(increment = 1)` allows you to pass a positive or negative value to increment the current hue

`api.hue_up(increment = 1)` pass a number to increase the hue by that amount, defaults to 1 without an argument

`api.hue_down(increment = 1)` pass a number to decrease the hue by that amount, defaults to 1 without an argument

`api.get_hue` gets the current hue level of the panel

#### color temperature
`api.set_ct(value)` sets the ct of the panel.

`api.ct_increment(increment = 1)` allows you to pass a positive or negative value to increment the current ct

`api.ct_up(increment = 1)` pass a number to increase the ct by that amount, defaults to 1 without an argument

`api.ct_down(increment = 1)` pass a number to decrease the ct by that amount, defaults to 1 without an argument

`api.get_ct` gets the current ct level of the panel


#### saturation
`api.set_ct(value)` sets the ct of the panel.

`api.ct_increment(increment = 1)` allows you to pass a positive or negative value to increment the current ct

`api.ct_up(increment = 1)` pass a number to increase the ct by that amount, defaults to 1 without an argument

`api.ct_down(increment = 1)` pass a number to decrease the ct by that amount, defaults to 1 without an argument

`api.get_ct` gets the current ct level of the panel


#### advanced color
`api.get_rgb` returns the current r,g,b value of the panel

`api.set_color(string)` allows you to set a color value from a name or a hex value -- for example `set_color('red')` or `set_color('#FFF')` or `set_color('#33FF33')`

`api.set_rgb(r, g, b)` allows you to pass an rgb value directly -- for example `set_rgb(123,100,200)`


#### effects
`api.effects_list` returns an array of strings that correspond to the names of all the effects on your Nanoleaf

`api.choose_effect(string)` changes the effect if it matches the name of one of the effects

`api.random_effect` changes the effect to a random effect

#### user commands
`api.delete_auth_token` removes the auth token you are using from the Nanoleaf (danger!)

`api.generate_auth_token` returns a new auth token if the Nanoleaf has been set into the new user mode (hold the power button for 5 seconds until the light starts blinking)

note: If you are setting up the panel for the first time and you know the IP address but don't have a token, you can instantiate the API with a bogus string for the token and still run this command, however no other command will work

```ruby
api = NanoleafRuby::Api.new(ip_address: '192.161.1.1:16021', token: 'foobar')
api.generate_auth_token
```

## Rake Tasks

To include rake tasks in a ruby app, create a Rakefile and put the following in it. Rails should get the task automatically.

```ruby
spec = Gem::Specification.find_by_name 'nanoleaf_ruby'
load "#{spec.gem_dir}/lib/tasks/rake_tasks.rb"
```
##### nanoleaf:generate_token
`rake 'nanoleaf:generate_token['192.168.1.1:16021']'`

If you want to generate an auth token via rake, just enter the ip address of your panel here (or have it set in `ENV['NANOLEAF_API_TOKEN']`

##### nanoleaf::autodiscover
`rake 'nanoleaf:autodiscover` will attempt to find your panel(s) via SSDP and print out information about them to the screen (including their IP addresses). I've had mixed luck with it showing up consistently.

## Console

If you want to drop straight into a console just run `bin/console`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/estiens/nanoleaf_ruby.

Please branch from dev for all pull requests.
* Fork it
* Checkout dev (`git checkout dev`)
* Create your feature branch (`git checkout -b my-new-feature`)
* Commit your changes (`git commit -am 'Add some feature'`)
* Push to the branch (`git push origin my-new-feature`)
* Create a new pull request against dev

## Tests

You can run tests with `rake spec`.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the nanoleaf_ruby project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/estiens/nanoleaf_ruby/blob/master/CODE_OF_CONDUCT.md).
