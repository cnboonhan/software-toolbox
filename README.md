# software-toolbox
Cut down development / troubleshooting time with this software bag-o-tricks!

Especially useful for multi device headless setups. Includes:

Automatic installation of various useful software, such as 
* [general development](https://github.com/cnboonhan/software-toolbox/blob/master/setup/dev-install)
* [code editing (Vim + Tmux + Plugins)](https://github.com/cnboonhan/software-toolbox/blob/master/setup/vim-install) 
* [Network troubleshooting](https://github.com/cnboonhan/software-toolbox/blob/master/setup/network-tools-install) 
* [Remote Desktop (TigerVNC)](https://github.com/cnboonhan/software-toolbox/blob/master/setup/vnc-gnome-install)
* [Docker](https://github.com/cnboonhan/software-toolbox/tree/master/setup) 
* [nodeJS](https://github.com/cnboonhan/software-toolbox/blob/master/setup/node-install).

Easily modifiable and well commented [templates](config) for various Linux administration files:
* [Netplan](https://github.com/cnboonhan/software-toolbox/blob/master/config/01-netplan-config.yaml)
* [CMake](https://github.com/cnboonhan/software-toolbox/blob/master/config/CMakeLists.txt)
* [DHCP Server ( dnsmasq )](https://github.com/cnboonhan/software-toolbox/blob/master/config/dnsmasq.conf)
* [WiFi Hotspot ( hostapd )](https://github.com/cnboonhan/software-toolbox/blob/master/config/hostapd.conf)
* [Tmux Scripting](https://github.com/cnboonhan/software-toolbox/blob/master/config/tmux-template)
* [udev](https://github.com/cnboonhan/software-toolbox/blob/master/config/udev-trigger-script.rules)
* [systemd](https://github.com/cnboonhan/software-toolbox/blob/master/config/systemd-template.service)
* [YouCompleteMe ( Vim )](https://github.com/cnboonhan/software-toolbox/blob/master/dotfiles/.ycm_extra_conf.py)

Feature packed [configurations](https://github.com/cnboonhan/software-toolbox/tree/master/dotfiles): 
* [vim](https://github.com/cnboonhan/software-toolbox/blob/master/dotfiles/.vimrc)
* [tmux](https://github.com/cnboonhan/software-toolbox/blob/master/dotfiles/.tmux.conf)
* [YoucompleteMe](https://github.com/cnboonhan/software-toolbox/blob/master/dotfiles/.ycm_extra_conf.py)
* [.bashrc](https://github.com/cnboonhan/software-toolbox/blob/master/dotfiles/.bashrc)

Useful [scripts](tools) to configure:
* [Automatic login on startup](https://github.com/cnboonhan/software-toolbox/blob/master/tools/tb-conf-autologin)
* [Whether to launch Graphical Interface ( X Server ) on startup](https://github.com/cnboonhan/software-toolbox/blob/master/tools/tb-conf-boot-interface)
* [WiFi power management under NetworkManager](https://github.com/cnboonhan/software-toolbox/blob/master/tools/tb-conf-power-management)
* [Netplan](https://github.com/cnboonhan/software-toolbox/blob/master/tools/tb-conf-netplan) 
* [Packet forwarding between two network interfaces](https://github.com/cnboonhan/software-toolbox/blob/master/tools/tb-conf-interface-forwarding)
* [Adding / Removing temporary swap space ( in case of insufficient RAM )](https://github.com/cnboonhan/software-toolbox/blob/master/tools/tb-conf-temp-swap-space)
* [Trigger commands on file/folder modifications: Useful for triggering automatic rebuilds on save](https://github.com/cnboonhan/software-toolbox/blob/master/tools/tb-run-cmd-on-update)
* [Mount remote devices locally over SSH](https://github.com/cnboonhan/software-toolbox/blob/master/tools/tb-sshfs-mount)
* [VNC Server for remote desktop access](https://github.com/cnboonhan/software-toolbox/blob/master/tools/tb-toggle-vnc-server-on-startup)

As well as various tmux configurations for easier development for
* [Bluetooth](https://github.com/cnboonhan/software-toolbox/blob/master/tools/tb-bluetooth-pane)
* [Git](https://github.com/cnboonhan/software-toolbox/blob/master/tools/tb-git-pane)
* [Systemd](https://github.com/cnboonhan/software-toolbox/blob/master/tools/tb-systemd-pane) 
* [Udev](https://github.com/cnboonhan/software-toolbox/blob/master/tools/tb-udev-pane) 
* [Network Configuration](https://github.com/cnboonhan/software-toolbox/blob/master/tools/tb-network-pane)
* [General Troubleshooting](https://github.com/cnboonhan/software-toolbox/blob/master/tools/tb-monitor-pane)

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
