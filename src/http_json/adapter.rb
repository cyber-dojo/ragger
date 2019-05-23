require 'uri'
require 'net/http'

module HttpJson

  class Adapter

    def get(hostname, port, path, args)
      json_request(hostname, port, path, args) do |url|
        Net::HTTP::Get.new(url)
      end
    end

    def post(hostname, port, path, args)
      json_request(hostname, port, path, args) do |url|
        Net::HTTP::Post.new(url)
      end
    end

    private

    def json_request(hostname, port, path, args)
      uri = URI.parse("http://#{hostname}:#{port}/#{path}")
      req = yield uri
      req.content_type = 'application/json'
      req.body = args.to_json
      service = Net::HTTP.new(uri.host, uri.port)
      service.request(req)
    end

  end

end
