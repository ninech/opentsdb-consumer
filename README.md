opentsdb-consumer
=================

[![Build Status](https://travis-ci.org/ninech/opentsdb-consumer.svg)](https://travis-ci.org/ninech/opentsdb-consumer)
[![Coverage Status](https://coveralls.io/repos/ninech/opentsdb-consumer/badge.svg?branch=master&service=github)](https://coveralls.io/github/ninech/opentsdb-consumer?branch=master)
[![Code Climate](https://codeclimate.com/github/ninech/opentsdb-consumer/badges/gpa.svg)](https://codeclimate.com/github/ninech/opentsdb-consumer)

Client library to fetch metrics from OpenTSDB.

## Installation

Add it to your Gemfile:

```ruby
gem 'opentsdb-consumer'
```

## Usage

```ruby
# First, you need a client.
client = OpenTSDBConsumer::Client.new host: 'metrics.yourdomain.com', port: 4242

# Default options
data = client.fetch(%w(metric1 metric2))

# Custom options for all the metrics
data = client.fetch(
  %w(metric1 metric2),
  rate: true,
  aggregator: 'avg',
  tags: { environment: 'production' },
  start: '24h-ago'
)

# Custom options for each metric
metric = OpenTSDBConsumer::Metric.new name: 'my.metric', rate: true, aggregator: 'avg', tags: { environment: 'production' }
data   = OpenTSDBConsumer::Query.new([metric], client).run start: '24h-ago'
```

The rate can be configured by providing an hash with the rate options.
```ruby
metric = OpenTSDBConsumer::Metric.new name: 'my.metric',
                                      rate: { counter: true, counterMax: 65535, resetValue: 2000 },
                                      aggregator: 'sum'
```

## Contributing to opentsdb-consumer

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

To test and debug you can use the debug script:

```sh
bin/opentsdb-consumer server.domain.com my.metric
```

## About

This gem is currently maintained and funded by [nine](https://nine.ch).

[![logo of the company 'nine'](https://logo.apps.at-nine.ch/Dmqied_eSaoBMQwk3vVgn4UIgDo=/trim/500x0/logo_claim.png)](https://www.nine.ch)
