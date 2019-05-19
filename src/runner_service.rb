require_relative 'http_helper'

class RunnerService

  def initialize(external)
    @http = HttpHelper.new(external, self, 'runner', 4597)
  end

  def ready?
    http.get
  end

  def run_cyber_dojo_sh(image_name, id, files, max_seconds)
    http.post(image_name, id, files, max_seconds)
  end

  private

  attr_reader :http

end
