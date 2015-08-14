require_relative "minitest_helper"

module Blogstats
  class CollectorTest < Minitest::Test
    def collect_from(input)
      Collector.stats_for(input)
    end

    def test_counts_one_post
      stats = collect_from("A post")
      assert_equal(1, stats.post_count)
    end

    def test_counts_words
      input = <<-EOF
Here are some words.

Here are some more. Why don't we try contractions?

How about a hyphenated-word?  Extra punctuation?!?!?!
      EOF
      stats = collect_from(input)
      assert_equal(19, stats.word_count)
    end
#
#     def test_skips_yaml_front_matter
#       input = <<-EOF
# ---
# field: value
# other_field: other_value
# ---
# two words
#       EOF
#       stats = collect_from(input)
#       assert_equal(2, stats.word_count)
#     end
  end
end
