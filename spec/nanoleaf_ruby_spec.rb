require 'webmock/rspec'
require 'pry'

RSpec.describe NanoleafRuby do
  it 'has a version number' do
    expect(NanoleafRuby::VERSION).not_to be nil
  end

  describe 'functionality' do
    let(:api) { NanoleafRuby::Api.new(ip_address: '0.0.0.0', token: 'foo') }
    let!(:stub) { stub_request(:any, 'http://0.0.0.0/api/v1/foo/state') }
    let(:requested_url) { '0.0.0.0/api/v1/foo/state' }

    context 'on/off' do
      it 'can turn the nanoleaf on' do
        api.on
        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'on': true} )
      end

      it 'can turn the nanoleaf off' do
        api.off
        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'on': false} )
      end

      it 'can toggle the nanoleaf off' do
        url = 'http://0.0.0.0/api/v1/foo/state/on/value'
        stub_request(:any, url).to_return(status: 200, body: 'true')
        api.toggle
        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'on': false } )
      end

      it 'can toggle the nanoleaf on' do
        url = 'http://0.0.0.0/api/v1/foo/state/on/value'
        stub_request(:any, url).to_return(status: 200, body: 'false')
        api.toggle
        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'on': true } )
      end
    end

    context 'brightness' do
      it 'can set the brightness without a duration' do
        api.set_brightness(50)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'brightness': { 'value': 50 } } )
      end

      it 'can set the brightness with a duration' do
        api.set_brightness(50, 25)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'brightness': { 'value': 50 , 'duration': 25} } )

      end

      it 'can increment the brightness with a positive value' do
        api.brightness_increment(75)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'brightness': { 'increment': 75 } } )
      end

      it 'can increment the brightness with a negative value' do
        api.brightness_increment(-75)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'brightness': { 'increment': -75 } } )
      end

      it 'can set the brightness up with a default value of 1' do
        api.brightness_up

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'brightness': { 'increment': 1 } } )
      end

      it 'can set the brightness up with any value' do
        api.brightness_up(10)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'brightness': { 'increment': 10 } } )
      end

      it 'can set the brightness down with a default value of 1' do
        api.brightness_down

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'brightness': { 'increment': -1 } } )
      end

      it 'can set the brightness down with any value' do
        api.brightness_down(10)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'brightness': { 'increment': -10 } } )
      end
    end

    context 'hue' do
      it 'can set the hue' do
        api.set_hue(50)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'hue': { 'value': 50 } } )
      end

      it 'can increment the hue with a positive value' do
        api.hue_increment(75)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'hue': { 'increment': 75 } } )
      end

      it 'can increment the hue with a negative value' do
        api.hue_increment(-75)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'hue': { 'increment': -75 } } )
      end

      it 'can set the hue up with a default value of 1' do
        api.hue_up

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'hue': { 'increment': 1 } } )
      end

      it 'can set the hue up with any value' do
        api.hue_up(10)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'hue': { 'increment': 10 } } )
      end

      it 'can set the hue down with a default value of 1' do
        api.hue_down

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'hue': { 'increment': -1 } } )
      end

      it 'can set the hue down with any value' do
        api.hue_down(10)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'hue': { 'increment': -10 } } )
      end
    end

    context 'sat' do
      it 'can set the saturation' do
        api.set_sat(50)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'sat': { 'value': 50 } } )
      end

      it 'can increment the saturation with a positive value' do
        api.sat_increment(75)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'sat': { 'increment': 75 } } )
      end

      it 'can increment the saturation with a negative value' do
        api.sat_increment(-75)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'sat': { 'increment': -75 } } )
      end

      it 'can set the saturation up with a default value of 1' do
        api.sat_up

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'sat': { 'increment': 1 } } )
      end

      it 'can set the saturation up with any value' do
        api.sat_up(10)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'sat': { 'increment': 10 } } )
      end

      it 'can set the saturation down with a default value of 1' do
        api.sat_down

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'sat': { 'increment': -1 } } )
      end

      it 'can set the saturation down with any value' do
        api.sat_down(10)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'sat': { 'increment': -10 } } )
      end
    end

    context 'ct' do
      it 'can set the color temp' do
        api.set_ct(50)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'ct': { 'value': 50 } } )
      end

      it 'can increment the ct with a positive value' do
        api.ct_increment(75)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'ct': { 'increment': 75 } } )
      end

      it 'can increment the ct with a negative value' do
        api.ct_increment(-75)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'ct': { 'increment': -75 } } )
      end

      it 'can set the ct up with a default value of 1' do
        api.ct_up

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'ct': { 'increment': 1 } } )
      end

      it 'can set the ct up with any value' do
        api.ct_up(10)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'ct': { 'increment': 10 } } )
      end

      it 'can set the ct down with a default value of 1' do
        api.ct_down

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'ct': { 'increment': -1 } } )
      end

      it 'can set the ct down with any value' do
        api.ct_down(10)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'ct': { 'increment': -10 } } )
      end
    end

    context 'color math' do
      it 'can set a color by name' do
        api.set_color('red')

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'hue': { 'value': 0 },
                                    'sat': { 'value': 100 },
                                    'brightness': { 'value': 100 }} )
                                    api.set_color('red')

        api.set_color('blue')

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'hue': { 'value': 240 },
                                    'sat': { 'value': 100 },
                                    'brightness': { 'value': 100 }} )
      end

      it 'can set a color by hex' do
        api.set_color('#fff')

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'hue': { 'value': 0 },
                                    'sat': { 'value': 0 },
                                    'brightness': { 'value': 100 }} )

        api.set_color('#000000')

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'hue': { 'value': 0 },
                                    'sat': { 'value': 0 },
                                    'brightness': { 'value': 0 }} )

      end

      it 'can set a color by rgb' do
        api.set_rgb(100,50,100)

        expect(WebMock).to have_requested(:put, requested_url)
                       .with(body: {'hue': { 'value': 300 },
                                    'sat': { 'value': 50 },
                                    'brightness': { 'value': 39 }} )


      end
    end
  end
end
