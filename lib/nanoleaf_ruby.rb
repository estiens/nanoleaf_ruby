require "nanoleaf_ruby/version"
require "nanoleaf_ruby/color_utils"
require "nanoleaf_ruby/base_requester"
require "errors/configuration_error"

require 'railtie' if defined?(Rails)

module NanoleafRuby
  class Api
    def initialize(token: nil, ip_address: nil, raise_errors: false)
      @access_token = ENV['NANOLEAF_API_TOKEN'] || token
      @nanoleaf_ip = ENV['NANOLEAF_IP_ADDRESS'] || ip_address
      @api_url = get_api_url
      @requester = BaseRequester.new(raise_errors: raise_errors)
    end

    # info dump from panels
    def info
      @requester.get(url: @api_url)
    end

    # power on/off
    def on
      params = { on: true }
      @requester.put(url: "#{@api_url}/state", params: params)
    end

    def off
      params = { on: false }
      @requester.put(url: "#{@api_url}/state", params: params)
    end

    def toggle
      response = @requester.get(url: "#{@api_url}/state/on/value")
      on = response.dig(:raw, :body) == 'true' ? true : false
      params = { on: !on }
      @requester.put(url: "#{@api_url}/state", params: params)
    end

    # color mode
    def color_mode
      @requester.get(url: "#{@api_url}/state/colorMode")
    end

    # flash panels
    def identify
      @requester.put(url: "#{@api_url}/identify")
    end

    # brightness commands
    def brightness_increment(increment = 1)
      params = { brightness: {} }
      params[:brightness][:increment] = increment
      @requester.put(url: "#{@api_url}/state", params: params)
    end

    def brightness_up(increment = 1)
      brightness_increment(increment)
    end

    def brightness_down(increment = 1)
      brightness_increment(-increment)
    end

    def set_brightness(value, duration = nil)
      params = { brightness: {} }
      params[:brightness][:value] = value
      params[:brightness][:duration] = duration if duration
      @requester.put(url: "#{@api_url}/state", params: params)
    end

    def get_brightness
      @requester.get(url: "#{@api_url}/state/brightness")
    end

    # hue commands
    def hue_increment(increment = 1)
      params = { hue: {} }
      params[:hue][:increment] = increment
      @requester.put(url: "#{@api_url}/state", params: params)
    end

    def hue_up(increment = 1)
      hue_increment(increment)
    end

    def hue_down(increment = 1)
      hue_increment(-increment)
    end

    def set_hue(value)
      params = { hue: {} }
      params[:hue][:value] = value
      @requester.put(url: "#{@api_url}/state", params: params)
    end

    def get_hue
      @requester.get(url: "#{@api_url}/state/hue")
    end

    # color temperature commands
    def ct_increment(increment = 1)
      params = { ct: {} }
      params[:ct][:increment] = increment
      @requester.put(url: "#{@api_url}/state", params: params)
    end

    def ct_up(increment = 1)
      ct_increment(increment)
    end

    def ct_down(increment = 1)
      ct_increment(-increment)
    end

    def set_ct(value)
      params = { ct: {} }
      params[:ct][:value] = value
      @requester.put(url: "#{@api_url}/state", params: params)
    end

    def get_ct
      @requester.get(url: "#{@api_url}/state/ct")
    end

    # saturation commands
    def sat_increment(increment = 1)
      params = { sat: {} }
      params[:sat][:increment] = increment
      @requester.put(url: "#{@api_url}/state", params: params)
    end

    def sat_up(increment = 1)
      sat_increment(increment)
    end

    def sat_down(increment = 1)
      sat_increment(-increment)
    end

    def set_sat(value)
      params = { sat: {} }
      params[:sat][:value] = value
      @requester.put(url: "#{@api_url}/state", params: params)
    end

    def get_sat
      @requester.get(url: "#{@api_url}/state/sat")
    end

    # color_commands
    def get_rgb
      hue = get_hue['value']
      saturation = get_sat['value']
      brightness = get_brightness['value']
      ColorUtils.hsv_to_rgb(hue, saturation, brightness)
    end

    def set_color(string)
      hsb = ColorUtils.get_color(string)
      write_color(hsb)
    end

    def set_rgb(r, g, b)
      hsb = ColorUtils.get_color("rgb(#{r},#{g},#{b})")
      write_color(hsb)
    end

    def write_color(hsb)
      params = { hue: { value: hsb[0] } }
      params[:sat] = { value: hsb[1] }
      params[:brightness] = { value: hsb[2] }
      @requester.put(url: "#{@api_url}/state", params: params)
    end

    # effects
    def effects_list
      response = @requester.get(url: "#{@api_url}/effects/effectsList")
      effects = response[:data]
    end

    def choose_effect(name)
      params = { select: name }
      @requester.put(url: "#{@api_url}/effects", params: params)
    end

    def random_effect
      choose_effect(effects_list.sample)
    end

    # user commands
    def delete_auth_token
      @requester.delete(url: @api_url)
    end

    def generate_auth_token
      response = @requester.post(url: "http://#{@nanoleaf_ip}/api/v1/new")
      if response[:success]
        puts 'Auth token successfully generated!'
        puts "Token: #{response.dig(:data,'auth_token')}"
      elsif response[:code] == 403
        puts 'Press and hold the power button for 5-7 seconds first!'
        puts '(Light will begin flashing)'
      else
        puts "Sorry, something went wrong and I don't know what!"
      end
    end

    private

    def get_api_url
      raise Errors::Configuration, "Nanoleaf IP address missing" unless @nanoleaf_ip
      raise Errors::Configuration, "Nanoleaf access token missing" unless @access_token
      "http://#{@nanoleaf_ip}/api/v1/#{@access_token}"
    end
  end
end
