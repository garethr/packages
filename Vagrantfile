# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.forward_port 80, 8082

  ['repo', 'debs'].each do |path|
    config.vm.share_folder path, path, path, :create => true
  end

  ['recipes', 'bin'].each do |path|
    config.vm.share_folder path, path, path
  end

  config.vm.provision :puppet, :options => ["--debug", "--verbose", "--summarize", "--reports", "store"] do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "base.pp"
  end
end
