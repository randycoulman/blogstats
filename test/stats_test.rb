require_relative "minitest_helper"

module Blogstats
  class StatsMergeTest < Minitest::Test
    def setup
      @stats1 = Stats.new(post_count: 3, word_count: 42)
      @stats2 = Stats.new(post_count: 2, word_count: 16)
      @merged = stats1.merge(stats2)
    end

    attr_reader :stats1, :stats2, :merged

    def test_sums_post_counts
      assert_equal(5, merged.post_count)
    end

    def test_sums_word_counts
      assert_equal(58, merged.word_count)
    end

    def test_returns_new_object
      refute_same(merged, stats1)
      refute_same(merged, stats2)
    end
  end
end
