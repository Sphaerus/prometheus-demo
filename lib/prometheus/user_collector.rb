# see:
# https://github.com/discourse/prometheus_exporter
# https://github.com/discourse/prometheus_exporter#global-metrics-in-a-custom-type-collector
#
# The metrics endpoint is called whenever prometheus calls the /metrics HTTP endpoint,
# it may make sense to introduce some caching so database calls are only performed once every N seconds.
# lru_redux is the perfect gem for that kind of job as you can LruRedux::TTL::Cache which will automatically expire after N seconds.

# load rails as we want to have access to the models in the promethues exporter process for global stats
unless defined? Rails
  require File.expand_path("../../../config/environment", __FILE__)
end

# Custom typ collector (runs together with main collector) for User Data,
# when started with:  bundle exec prometheus_exporter -a ./lib/prometheus/user_collector.rb
#
class UserCollector < PrometheusExporter::Server::TypeCollector

  def type
    "user"
  end

  def metrics
    users_count_gague = PrometheusExporter::Metric::Gauge.new('your_app_users_count', 'number of active users in the app')

    # global collectors
    users_count_gague.observe rand(100), scope: 'active'
    users_count_gague.observe rand(100), scope: 'inactive'

    [users_count_gague]
  end
end
