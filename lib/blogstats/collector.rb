require_relative "stats"

module Blogstats
  class Collector
    def self.stats_for(input)
      new(input).stats
    end

    def initialize(input)
      @stats = collect_stats(input)
    end

    attr_reader :stats

    private

    def collect_stats(input)
      stats = Stats.new
      stats.add_post
      input.each_line.each_with_object(stats) do |line, stats|
        stats.add_words(line.split.count)
      end
    end
  end
end
