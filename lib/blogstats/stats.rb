require "ostruct"

module Blogstats
  class Stats < OpenStruct
    def initialize(*)
      super
      self.post_count ||= 0
      self.word_count ||= 0
      self.loc ||= 0
      self.images ||= 0
      self.videos ||= 0
    end

    def add_post
      self.post_count += 1
    end

    def add_words(words)
      self.word_count += words
    end

    def add_loc
      self.loc += 1
    end

    def add_image
      self.images += 1
    end

    def add_video
      self.videos += 1
    end

    def merge(other_stats)
      hash = each_pair.with_object({}) do |(key, value), merged|
        merged[key] = value + other_stats[key]
      end
      self.class.new(hash)
    end

    def to_s
      <<-EOF
Posts:  #{post_count}
Words:  #{word_count}
LOC:    #{loc}
Images: #{images}
Videos: #{videos}
      EOF
    end
  end
end
