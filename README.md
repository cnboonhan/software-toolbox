# software-toolbox
This repository aims to make it easy to install and restore my preferred working environment on a new machine / container. It also contains useful scripts and helper commands to make development more familiar.

## Installation
```
git clone https://github.com/cnboonhan/software-toolbox
cd software-toolbox
./setup/dev-install
```

## Docker Image
It is possible to create a Docker container with this working environment. After [installing Docker](https://docs.docker.com/engine/install/ubuntu/), and following the [post-installation steps](https://docs.docker.com/engine/install/linux-postinstall/), do the following.

```
git clone https://github.com/cnboonhan/software-toolbox
cd software-toolbox
docker build -t cnboonhan/software-toolbox-env .
docker run -it -w /home/ubuntu cnboonhan/software-toolbox-env /bin/bash
```

You could also pull a docker image from my Docker Hub:
```
docker pull quay.io/cnboonhan/software-toolbox-env:latest
docker tag quay.io/cnboonhan/software-toolbox-env cnboonhan/software-toolbox-env
docker rmi quay.io/cnboonhan/software-toolbox-env
```

## Sandbox 
A helper script has been made to quickly launch a sandbox Docker container based on `software-toolbox-env` image.
```
[PATH-to-software-toolbox-repository]/tools/sandbox
```
If you want to make this script easily accessible, consider copying it into one of your default executable PATHs:
```
sudo cp [PATH-to-software-toolbox-repository]/tools/sandbox /usr/local/bin
# Now you can run sandbox in the shell
sandbox # Interactive BASH terminal
sandbox [command] # Run command and exit sandbox 
```

This would have already been done if you followed the `Installation` steps above.
