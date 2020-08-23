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

# Set Entrypoint Script
COPY sandbox-entrypoint.sh /usr/local/bin
ENTRYPOINT ["sandbox-entrypoint.sh"]
