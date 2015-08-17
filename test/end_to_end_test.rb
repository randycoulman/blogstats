require_relative 'minitest_helper'
require "pathname"
require "tmpdir"

module Blogstats
  class EndToEndTest < Minitest::Test
    def setup
      @dir = Pathname.new(Dir.tmpdir)
      create_sample_files(dir)
    end

    def teardown
      dir.rmtree
    end

    def test_end_to_end
      expected_output = <<-EOF
Posts:  2
Words:  20
Images: 2
Videos: 1
      EOF
      assert_output(expected_output, "") do
        CLI.run([dir])
      end
    end

    private

    attr_reader :dir

    def create_sample_files(dir)
      (dir / "post1.md").write(post1_content)
      (dir / "post2.md").write(post2_content)
    end

    def post1_content
      <<-EOF
---
layout: post
title: Post 1
---
This is some basic post test.

{% codeblock This is a code block lang:ruby %}
class Foo
  def bar
    puts "Hello, world!"
  end
end
{% endcodeblock %}

Here's another paragraph.

{% img center /path/to/image.png 400 300 Caption AltText %}

{% codeblock Another code block lang:ruby %}
require "minitest/autorun"

class FooTest < Minitest::Test
  def setup
    @foo = Foo.new
  end

  attr_reader :foo

  def test_bars
    assert_equal("Hello, world!", foo.bar)
  end
end
{% endcodeblock %}
      EOF
    end

    def post2_content
      <<-EOF
---
layout: post
title: Post 2
---
This is another post.

{% youtube some_id %}

It has another paragraph.

{% img center /path/to/image.png 400 300 Caption AltText %}

And then another.
      EOF
    end
  end
end
