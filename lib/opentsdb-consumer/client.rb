require 'excon'
require 'forwardable'

module OpenTSDBConsumer
  class Client
    extend Forwardable
    attr_reader :host, :port, :connection

    delegate get:  :connection
    delegate post: :connection

    def initialize(host: 'localhost', port: 4242, options: {})
      @host = host
      @port = port
      @connection = Excon.new url, options
    end

    def fetch(metric_names, options = {})
      options = {
        start: '8h-ago',
        aggregator: 'sum',
        downsample: '5m-avg',
        rate: false,
        tags: {},
      }.merge(options)

      metrics = build_metrics(metric_names, options)

      Query.new(metrics, self).run(start: options[:start])
    end

    def url
      "http://#{host}:#{port}/api/query"
    end

    private

    def build_metrics(metric_names, options)
      metric_names.map do |metric|
        Metric.new(whitelisted_metric_options(options).merge(name: metric))
      end
    end

    def whitelisted_metric_options(options)
      options.select { |key, _| Metric::ATTRIBUTES_WHITELIST.include?(key) }
    end
  end
end
