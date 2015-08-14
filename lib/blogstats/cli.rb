require_relative "collector"
require_relative "stats"

module Blogstats
  class CLI
    def self.run(args = ARGV)
      new.run(args)
    end

    def run(args = ARGV)
      directory = Pathname.new(args.empty? ? Dir.getwd : args.first)
      stats = directory.each_child.reject(&:directory?).map { |file| stats_for(file) }.reduce(&:merge)
      puts stats
    end

    private

    def stats_for(file)
      Collector.stats_for(file)
    end
  end
end
