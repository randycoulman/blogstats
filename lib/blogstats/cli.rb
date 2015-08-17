require_relative "collector"
require_relative "stats"

module Blogstats
  class CLI
    def self.run(args = ARGV)
      new.run(args)
    end

    def run(args = ARGV)
      directory = Pathname.new(args.empty? ? Dir.getwd : args.first)
      puts directory.each_child
             .reject(&:directory?)
             .map(&method(:stats_for))
             .reduce(&:merge)
    end

    private

    def stats_for(file)
      Collector.stats_for(file)
    end
  end
end
