module OpenTSDBConsumer
  class Rate
    attr_reader :options

    def initialize(options_or_true = {})
      @options = options_or_true.is_a?(Hash) ? options_or_true : {}
    end

    def to_h
      hash = { rate: true }
      hash[:rateOptions] = options if options.any?
      hash
    end

    def to_s
      string = 'rate'
      string += ":rateOptions{#{compiled_options}}" if options.any?
      string
    end

    private

    def compiled_options
      return '' if options.empty?
      options.map { |key, value| [key, value].join '=' }.join(',')
    end
  end
end
