require_relative '../src/http_hostname_port'
require 'json'
require 'ostruct'

class HttpStub

  def initialize(response)
    @response = OpenStruct.new(body:JSON.generate(response))
  end

  include HttpHostnamePort

  def get(_method, _named_args)
    @response
  end

  def post(_method, _named_args)
    @response
  end

end
