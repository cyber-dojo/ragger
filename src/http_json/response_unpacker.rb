require 'json'

module HttpJson

  class ResponseUnpacker

    def initialize(requester)
      @requester = requester
    end

    def get(path, args)
      response = @requester.get(path, args)
      unpacked(response.body, path.to_s)
    end

    def post(path, args)
      response = @requester.post(path, args)
      unpacked(response.body, path.to_s)
    end

    private

    def unpacked(body, path)
      json = JSON.parse(body)
      unless json.is_a?(Hash)
        fail 'json is not a Hash'
      end
      if json.key?('exception')
        fail JSON.pretty_generate(json['exception'])
      end
      unless json.key?(path)
        fail "key for '#{path}' is missing"
      end
      json[path]
    end

  end

end
