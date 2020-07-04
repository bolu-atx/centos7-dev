# centos7-dev
Docker file and docker-compose for you to get a centos7 based dev environment for modern C++ up and running very quickly. Can be used with CLion, VSCode, or your own choice of dev tools by SSHing into the docker container once initialized.

Default user/pass is dev:dev, root user/pass is root:root

# Tools Installed
- git
- gcc 4.8.5
- gdb 8
- openssl
- cmake
- make
- valgrind
- wget, zlib, rpm-build, gbzip, tar
- ssh server

# How to Use

## via docker-compose

Navigate to the root directory of this repo once cloned

```
docker-compose up -d
```

If successful, you should see a container running if you do `docker ps`

## OR - via docker

### 1. Build Docker Image

```
docker build -t centos7-cpp ./
```

### 2. Run docker image in detached state

Feel free to map the ports to whatever you like, I just picked something I liked
```
docker run -d -p 5566:22 -p 6677:7777 centos7-cpp
```

## Configure IDE
### 3. [Optional] Setup CLion

- Go to [Settings] -> [Build, Execution and Deployment] ->  [Toolchains] (or just search for Toolchain in the setting searchbox)
- Click the "+" sign to add a new environment, select "Remote Host"
- Use the following credentials:
    - Host: 127.0.0.1
    - Username: dev
    - Password: dev
    - Port: 5566
- Click "Test Connection" to see if you can connect
- Once successful, Go to [Settings] -> [Build, Execution and Deployment] -> [CMake]
- Select "Toolchain" to the new "Remote Host" just created


### 4. Setup with VSCode

- Install Docker extension
- Go to the Docker tag - in the list containers, you should see the "Running container" with the container we just launched from step 2.
- Right click on it, click "Attach Visual Studio Code"


## How to Extend and Customize

### Temporary packages for a container instance

Make sure the container is already running
```
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                                          NAMES
f659a6ab9b67        centos7-dev_dev     "/start.sh"         21 hours ago        Up 14 minutes       0.0.0.0:7777->7777/tcp, 0.0.0.0:5566->22/tcp   dev
```

Attach to it via
```
docker exec -it <container ID> /bin/bash
```

Install packages or configure as you see fit, as long as the container instance is not pruned, the changes will persist through that instance.


### Create a new docker image

If you want to make the local customizations part of the docker image itself to avoid customizing it for every container instance, you can make changes directly to the docker file and the setup script to build a new docker image.


Modify `Dockerfile` or `setup.sh` to install packages of your choice. Then build/tag a new docker image
```
docker build ./ -t <new tag>
```
The convention I follow is, anything custom or requries more steps should go into the setup.sh, the Dockerfile should contain a minimum set of commands to avoid getting too many layers generated (yum installs are okay in the Dockerfile)


Feel free to fork this repo, modify the setup.sh (for non- or the Dockerfile to install additional tools of your choice.