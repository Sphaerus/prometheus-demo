unless Rails.env == "test"

  # NOTE: as we have different processes but want 1 interface for prometheus to scrape the metrics
  # we send the metrics to a collector container
  # this process need to be started as a separate process
  #
  # Prometheus Ports:
  # https://github.com/prometheus/prometheus/wiki/Default-port-allocations

  # Connect to Prometheus Collector Process
  require 'prometheus_exporter/client'
  metric_host = Rails.application.secrets.prometheus_export_collector_host
  my_client = PrometheusExporter::Client.new(host: metric_host,
                                             port: PrometheusExporter::DEFAULT_PORT)

  # Set Default Client
  PrometheusExporter::Client.default = my_client

  # This reports stats per request like HTTP status and timings
  require 'prometheus_exporter/middleware'
  Rails.application.middleware.unshift PrometheusExporter::Middleware


  # this reports basic process stats like RSS and GC info
  require 'prometheus_exporter/instrumentation'
  PrometheusExporter::Instrumentation::Process.start(type: "master")

  # as puma run in 1 process, we don't need any additional config for the web frontends
  # see config/sidekiq.rb for sidekiq config
end
