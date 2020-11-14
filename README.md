# software-toolbox
Cut down development time with this software bag-o-tricks!

Especially useful for multi device headless setups.

Contains easily modifiable [templates](config) and [configurations](dotfiles) for
* Netplan
* CMake
* DHCP Server ( dnsmasq )
* WiFi Hotspot ( hostapd )
* Tmux ( windows and panes )
* Vim
* udev
* systemd
* YouCompleteMe ( Vim )
* bashrc

Contains useful [scripts](tools) to configure:
* Automatic login on startup
* Graphical interface / terminal on startup 
* WiFi power management under NetworkManager
* Netplan 
* Packet forwarding between two network interfaces
* Adding / Removing temporary swap space ( in case of insufficient RAM )
* Trigger commands on file/folder modifications
* Mount remote devices locally over SSH

As well as various tmux configurations for easier development for
* Bluetooth
* Git
* Systemd services
* Udev 
* Network Troubleshooting

## Quick Setup 
Note that running `dev-install` will overwrite certain [configuration files](dotfiles). Make sure to back them up!
```
git clone https://github.com/cnboonhan/software-toolbox
cd software-toolbox
./setup/dev-install
```

## Docker Image
This toolbox is available as a Docker image:
```
docker pull quay.io/cnboonhan/software-toolbox:latest
docker tag quay.io/cnboonhan/software-toolbox cnboonhan/software-toolbox
docker rmi quay.io/cnboonhan/software-toolbox
```
or you could build it yourself:

```
git clone https://github.com/cnboonhan/software-toolbox
cd software-toolbox
docker build -t cnboonhan/software-toolbox .
docker run -it -w /home/ubuntu cnboonhan/software-toolbox /bin/bash
```
