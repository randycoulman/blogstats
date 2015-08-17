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

    JEKYLL_TAG = /^\{% .* %\}$/

    def collect_stats
      stats.add_post

      skip_yaml_front_matter
      while line = input.next.strip
        if line =~ /^\{%\s+codeblock.*%\}$/ .. line =~ /^\{%\s+endcodeblock.*%\}$/
          process_loc(line)
        else
          process_line(line)
        end
      end
    rescue StopIteration
    end

    def process_loc(line)
      return if line =~ JEKYLL_TAG

      stats.add_loc
    end

    def process_line(line)
      case line
        when /^\{%\s+youtube.*%\}$/
          stats.add_video
        when /^\{%\s+img.*%\}$/
          stats.add_image
        when JEKYLL_TAG
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
