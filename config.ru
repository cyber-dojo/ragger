$stdout.sync = true
$stderr.sync = true

require 'rack'
use Rack::Deflater, if: ->(_, _, _, body) { body.any? && body[0].length > 512 }

unless ENV['NO_PROMETHEUS']
  require 'prometheus/middleware/collector'
  require 'prometheus/middleware/exporter'
  use Prometheus::Middleware::Collector
  use Prometheus::Middleware::Exporter
end

require_relative 'src/externals'
require_relative 'src/rack_dispatcher'
require_relative 'src/traffic_light'
externals = Externals.new
traffic_light = TrafficLight.new(externals)
dispatcher = RackDispatcher.new(traffic_light)
Rack::Handler::Thin.run(dispatcher,{ Port:5537 }) do |server|
  server.threaded = true
end
