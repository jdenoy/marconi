# -*- mode: ruby -*-
# vi: set ft=ruby :

$gnu_radio_bootstrap = <<SCRIPT
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install build-essential git subversion
wget http://www.sbrac.org/files/build-gnuradio && chmod a+x ./build-gnuradio && ./build-gnuradio
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # run the basic GNU Radio bootstrap stuff
  config.vm.provision :shell, :inline => $gnu_radio_bootstrap
end
