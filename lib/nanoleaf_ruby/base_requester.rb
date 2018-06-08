require 'httparty'

module NanoleafRuby
  class BaseRequester
    include HTTParty

    def initialize(raise_errors: false)
      @raise_errors = raise_errors
    end

    def get(url:)
      response = self.class.get(url)
      parse_response(response: response)
    end

    def put(url:, params: {}, headers: {})
      body = params.to_json
      headers = headers.merge('Content-Type' => 'application/json',
                              'Content-Length' => body.length.to_s)
      response = self.class.put(url, body: body, headers: headers)
      parse_response(response: response, params: params)
    end

    def post(url:, params: {}, headers: {})
      response = self.class.post(url, body: params.to_json, headers: headers)
      parse_response(response: response, params: params)
    end

    def delete(url:, params: {})
      self.class.delete(url, body: params.to_json)
    end

    private

    # rubocop:disable Metrics/MethodLength
    def error_lookup(error_code)
      case error_code
      when 401
        'Not authorized! This is an invalid token. Try calling generate_auth_token'
      when 404
        'Resource not found'
      when 422
        'Unprocessible Entity (check your params?)'
      when 500
        'Internal Server Error'
      else
        'Something went wrong'
      end
    end
    # rubocop:enable Metrics/MethodLength

    def parse_response(response:, params: nil, body: {})
      if response.code < 299
        body[:data] = parse_json(response.body)
        body[:success] = true
      else
        error = write_error_message(response)
        body[:error] = error
        body[:success] = false
      end
      body[:code] = response.code
      body.merge!(raw: { body: response.body, params: params })
    end

    def write_error_message(response)
      error = "Error #{response.code}: #{error_lookup(response.code)}"
      raise error if @raise_errors
      error
    end

    def parse_json(json_string)
      body = {}
      begin
        body = JSON.parse(json_string) if json_string && !json_string.empty?
      rescue JSON::ParserError
        return {}
      end
      body
    end
  end
end
