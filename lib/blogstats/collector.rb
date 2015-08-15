require_relative "stats"

module Blogstats
  class Collector
    def self.stats_for(input)
      new(input).stats
    end

    def initialize(input)
      @input = input.each_line
      @stats = Stats.new
      collect_stats
    end

    attr_reader :stats

    private

    attr_reader :input

    def collect_stats
      stats.add_post

      skip_yaml_front_matter
      while line = input.next.strip
        process_line(line)
      end
    rescue StopIteration
    end

    def process_line(line)
      case line
        when /^\{%\s+youtube.*%\}/
          stats.add_video
        when /^\{% .* %\}/
          return
        else
          stats.add_words(line.split.count)
      end
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
