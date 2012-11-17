require 'rubygems'
require 'pathname'
require 'io/console'
require 'vagrant'

namespace :repo do
  desc "Build the repository"
  task :build do
    env = Vagrant::Environment.new
    raise "Must run `vagrant up`" if !env.primary_vm.created?
    raise "Must be running!" if env.primary_vm.state != :running
    puts "Enter your gpg passphrase"
    passphrase = STDIN.noecho(&:gets).chomp
    puts "Running build script"
    env.primary_vm.channel.execute("PASSPHRASE=#{passphrase} ./build.sh") do |type, data|
      puts data
      $stdout.flush
    end
  end
end

namespace :recipes do
  desc "Build a package from one of the available recipes"
  task :build, :recipe do |t, args|
    env = Vagrant::Environment.new
    raise "Must run `vagrant up`" if !env.primary_vm.created?
    raise "Must be running!" if env.primary_vm.state != :running
    raise "Must specify a recipe" unless args[:recipe]
    env.primary_vm.channel.execute("recipes/#{args[:recipe]}.sh") do |type, data|
      puts data
      $stdout.flush
    end
  end

  desc "List available recipes"
  task :list do
    Pathname.glob('recipes/*').map { |a| puts a.basename.to_s.gsub('.sh', '') }
  end
end
