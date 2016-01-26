module OpenTSDBConsumer
  class Tags < Hash
    def initialize(tags = {})
      merge!(tags)

      check_tags!
    end

    def to_s
      map do |key, value|
        [key, value].join '='
      end.join(',')
    end

    private

    def check_tags!
      each do |key, value|
        raise EmptyTag if key && (value.nil? || value.to_s.empty?)
      end
    end
  end
end
