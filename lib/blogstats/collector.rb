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

    BEGIN_CODE_BLOCK = /^\{%\s+codeblock.*%\}$/
    END_CODE_BLOCK = /^\{%\s+endcodeblock.*%\}$/
    VIDEO_TAG = /^\{%\s+youtube.*%\}$/
    IMAGE_TAG = /^\{%\s+img.*%\}$/
    OTHER_JEKYLL_TAG = /^\{% .* %\}$/
    REFERENCE_STYLE_LINK = /^\[.+\]:/

    def collect_stats
      skip_yaml_front_matter
      process_post_body
    rescue StopIteration
    end

    def process_post_body
      stats.add_post

      while line = input.next.strip
        if line =~ BEGIN_CODE_BLOCK .. line =~ END_CODE_BLOCK
          process_code_block(line)
        else
          process_line(line)
        end
      end
    end

    def process_code_block(line)
      unless line =~ BEGIN_CODE_BLOCK || line =~ END_CODE_BLOCK
        stats.add_loc
      end
    end

    def process_line(line)
      case line
        when VIDEO_TAG
          stats.add_video
        when IMAGE_TAG
          stats.add_image
        when OTHER_JEKYLL_TAG
          return
        when REFERENCE_STYLE_LINK
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
