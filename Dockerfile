FROM ubuntu:latest
MAINTAINER Charayaphan Nakorn Boon Han "charayaphan.nakorn.boon.han@gmail.com"

RUN apt update
RUN apt install sudo -y
RUN apt install git -y

# new user configuration
ENV USER=ubuntu
ENV USER_EMAIL="placeholder@email.com"
ARG UID=1000
ARG GID=1000
ARG PW=docker
ARG TIMEZONE=Asia/Singapore
ARG ROS1_DISTRO="noetic"
ARG ROS2_DISTRO="foxy"

RUN useradd -m ${USER} --uid=${UID} && echo "${USER}:${PW}" | \
      chpasswd

# make user sudo, no passwd needed
RUN usermod -aG sudo $USER 
RUN echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Disable error message and interactive prompts
RUN echo "Set disable_coredump false" >> /etc/sudo.conf
RUN DEBIAN_FRONTEND=noninteractive apt install keyboard-configuration -y
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

# Install tshark in dockerfile due to difficulties in setting non-root use non-interactively
RUN groupadd wireshark 
RUN DEBIAN_FRONTEND=noninteractive apt install tshark -y
RUN apt install wavemon -y
RUN setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/bin/dumpcap # Allow tshark / wireshark to run as non-root
RUN setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/bin/wavemon 
RUN chgrp wireshark /usr/bin/dumpcap
RUN usermod -a -G wireshark $USER
RUN chmod u+s /usr/bin/dumpcap

# set new user as default
USER ${USER}
WORKDIR /home/${USER}

# Download toolbox
RUN mkdir -p /home/$USER/repos && \
  git clone https://github.com/cnboonhan/software-toolbox /home/$USER/repos/software-toolbox

# Build everything
RUN /home/$USER/repos/software-toolbox/setup/dev-install

# Install ROS2, ROS1 and Gazebo
RUN sudo apt update && sudo apt install -q -y \
    bash-completion \
    dirmngr \
    gnupg2 \
    lsb-release \
    python3-pip \
    && sudo rm -rf /var/lib/apt/lists/*

RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/ros-latest.list
RUN echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -sc` main" | sudo tee /etc/apt/sources.list.d/ros2-latest.list
RUN sudo apt update 
RUN sudo apt install ros-$ROS1_DISTRO-ros-base -y
RUN sudo apt install ros-$ROS2_DISTRO-ros-base -y

RUN wget https://raw.githubusercontent.com/ignition-tooling/release-tools/master/one-line-installations/gazebo.sh -O $HOME/gazebo.sh && chmod +x $HOME/gazebo.sh && $HOME/gazebo.sh && rm $HOME/gazebo.sh

# Set Entrypoint Script
COPY sandbox-entrypoint.sh /usr/local/bin
ENTRYPOINT ["sandbox-entrypoint.sh"]
