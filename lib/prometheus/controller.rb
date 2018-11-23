# /lib/prometheus/controller.rb

module Prometheus
  module Controller

    # Create a default Prometheus registry for our metrics.
    prometheus = Prometheus::Client.registry

    # Create a simple gauge metric.
    RANDOM = Prometheus::Client::Gauge.new(:random_lol, 'A simple gauge that rands between 1 and 100 inclusively.')
    HTTP_COUNTER = Prometheus::Client::Counter.new(:http_requests, 'A counter of HTTP requests made')
    # Register GAUGE_EXAMPLE with the registry we previously created.
    prometheus.register(HTTP_COUNTER)
  end
end
