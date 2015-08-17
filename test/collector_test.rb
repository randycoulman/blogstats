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

    def test_skips_yaml_front_matter
      input = <<-EOF
---
field: value
other_field: other_value
---
      EOF
      stats = collect_from(input)
      assert_equal(0, stats.word_count)
    end

    def test_counts_only_hyperlink_text
      input = "[Some hyperlink text](http://example.com)"
      stats = collect_from(input)

      assert_equal(3, stats.word_count)
    end

    def test_skips_code_blocks
      input = <<-EOF
{% codeblock This is a codeblock lang:ruby %}
puts "Here is some Ruby code"
{% endcodeblock %}
      EOF
      stats = collect_from(input)
      assert_equal(0, stats.word_count)
    end

    def test_counts_videos
      input = "{% youtube some_id %}"
      stats = collect_from(input)
      assert_equal(0, stats.word_count)
      assert_equal(1, stats.videos)
    end

    def test_counts_image_links
      input = "{% img center /path/image.png 250 200 Caption Alt-text %}"
      stats = collect_from(input)
      assert_equal(0, stats.word_count)
      assert_equal(1, stats.images)
    end
  end
end
