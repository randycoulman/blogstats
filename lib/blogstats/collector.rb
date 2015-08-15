require_relative "stats"

module Blogstats
  class Collector
    def self.stats_for(input)
      new(input).stats
    end

    def initialize(input)
      @input = input.each_line
      @stats = collect_stats
    end

    attr_reader :stats

    private

    attr_reader :input

    def collect_stats
      stats = Stats.new
      stats.add_post

      skip_yaml_front_matter
      while line = input.next.strip
        next if line =~ /^\{% .* %\}/

        stats.add_words(line.split.count)
      end
    rescue StopIteration
      return stats
    end

    def skip_yaml_front_matter
      return unless input.peek =~ /^---/
      input.next

      while input.next !~ /^---/
        # Skip
      end
    end
  end
end
