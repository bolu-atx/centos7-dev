# centos7-dev
Docker file for a centos7 based dev environment for C++. Can be used with CLion, VSCode, or your own choice of dev tools by SSHing into the docker container once initialized.

Default user/pass is dev:dev, root user/pass is root:root

# Tools Installed
- git
- gcc 4.8.5
- openssl
- cmake
- make
- valgrind
- wget, zlib, rpm-build, gbzip, tar
- ssh server

# How to Use

## via docker-compose

Navigate to this repo

```
docker-compose up -d
```

## OR - Through docker

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


## How to Extend

### Temporary packages for a container instance

Launch docker in interactive mode and install
```
docker run it -p 5566:22 -p 7777:7777 centos7-cpp /bin/bash
```

Start sshd in the interactive mode session

```
/start.sh
```

### Create a new docker image

Modify `Dockerfile` or `setup.sh` to install packages of your choice. Then build/tag a new docker image
```
docker build ./ -t <new tag>
```


- Feel free to fork this repo, modify the setup.sh (for non- or the Dockerfile to install additional tools of your choice.
