require 'rubygems'
require 'pathname'
require 'io/console'

namespace :repo do
  desc "Build the repository"
  task :build do
    puts "Enter your gpg passphrase"
    passphrase = STDIN.noecho(&:gets).chomp
    puts "Running build script"
    `vagrant ssh -c "PASSPHRASE=#{passphrase} ./bin/build.sh"`
  end
end

namespace :recipes do
  desc "Build a package from one of the available recipes"
  task :build, :recipe do |t, args|
    raise "Must specify a recipe" unless args[:recipe]
    `vagrant ssh -c "recipes/#{args[:recipe]}.sh"`
  end

  desc "List available recipes"
  task :list do
    Pathname.glob('recipes/*').map { |a| puts a.basename.to_s.gsub('.sh', '') }
  end
end
