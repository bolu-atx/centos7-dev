# centos7-dev
Docker file for a centos7 based dev environment for C++

# Tools Installed
- git
- gcc 4.8.5
- openssl
- cmake
- make
- valgrind
- wget, zlib, rpm-build, gbzip, tar
- ssh server


# How to Use With CLion

### 1. Build Docker Image

```
docker build -t centos7-cpp ./
```

### 2. Run docker image in detached state

Feel free to map the ports to whatever you like, I just picked something I liked
```
docker run -d -p 5566:22 -p 6677:7777 centos7-cpp
```

### 3. Setup CLion

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

