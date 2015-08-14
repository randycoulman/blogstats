module Blogstats
  class Stats
    attr_reader :post_count, :word_count

    def initialize(post_count: 0, word_count: 0)
      @post_count = post_count
      @word_count = word_count
    end

    def add_post
      @post_count += 1
    end

    def add_words(words)
      @word_count += words
    end

    def merge(other_stats)
      self.class.new(
        post_count: post_count + other_stats.post_count,
        word_count: word_count + other_stats.word_count
      )
    end

    def to_s
      <<-EOF
Posts: #{post_count}
Words: #{word_count}
      EOF
    end
  end
end
