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
Posts: 2
Words: 20
      EOF
      assert_output(expected_output, "") do
        CLI.run([dir])
      end
    end

    private

    attr_reader :dir

    def create_sample_files(dir)
      (dir / "post1.md").write(post1_content)
    end

    def post1_content
      <<-EOF
---
layout: post
title: Post 1
---
This is some basic post test.

Here's another paragraph.
      EOF
    end

    def post2_content
      <<-EOF
---
layout: post
title: Post 2
---
This is another post.

It has another paragraph.

And then another.
      EOF
    end
  end
end
