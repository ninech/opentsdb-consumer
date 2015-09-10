opentsdb-consumer [![Build Status](https://travis-ci.org/ninech/opentsdb-consumer.svg)](https://travis-ci.org/ninech/opentsdb-consumer)
=================

Client library to fetch metrics from OpenTSDB.

## Usage

```ruby
client = OpenTSDBConsumer::Client.new host: 'metrics.yourdomain.com', port: 4242
metric = OpenTSDBConsumer::Metric.new name: 'my.metric', rate: true, aggregator: 'avg'
OpenTSDBConsumer::Query.new(metric, client).run start: '24h-ago'
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

## Copyright

Copyright (c) 2015 Nine Internet Solutions AG. See LICENSE.txt for
further details.

