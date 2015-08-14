module Blogstats
  class CLI
    def self.run(args = ARGV)
      new.run(args)
    end

    def run(args = ARGV)
      puts "CLI goes here!"
    end
  end
end
