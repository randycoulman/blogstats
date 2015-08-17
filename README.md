# Blogstats

Compute simple statistics about an Octopress/Jekyll-style blog.

This is designed for my [Courageous Software blog](http://randycoulman.com/blog/), but might be useful for others as well.

## Usage

Clone the repository, then run:

```
bin/setup
bundle exec exe/blogstats <path/to/your/blog/posts>
```

This will print a number of statistics about the blog:
* Number of posts
* Number of words of text
* Number of lines of code (LOC)
* Number of images
* Number of videos

`blogstats` assumes that:
* code will use the Octopress `{% codeblock %} ... {% endcodeblock %}` tags
* images will use the Octopress `{% img %}` tag
* videos will use the Octopress `{% youtube %}` tag

All other Jekyll-style tags are ignored.

`blogstats` skips over the YAML front-matter at the top of each post.

`blogstats` ignores the URL part of links, including reference-style links.  However, it currently assumes that reference-style links will be single-word only.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

1. Fork it ( https://github.com/randycoulman/blogstats/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
