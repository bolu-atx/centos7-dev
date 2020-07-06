FROM centos:centos7
LABEL version="0.1"
LABEL description="a centos7 based docker image for c++ development"
LABEL maintainer="bolu-atx"

RUN yum clean all && \
    yum -y install epel-release && \
    yum -y install git gcc-c++ openssl-static openssl-devel make chrpath \
        valgrind wget which openssl-libs libicu zlib git libtool rpm-build gzip tar \
        openssh openssh-server openssh-clients && \
    yum -y install centos-release-scl && \
    yum -y install devtoolset-8-gdb && \
    yum -y clean all

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LD_LIBRARY_PATH /usr/local/lib64:/usr/local/lib
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig
ENV TERM=xterm-256color

WORKDIR /tmp
COPY setup-gcc493.sh /tmp/setup.sh

# Run setup script
RUN bash /tmp/setup.sh && rm /tmp/setup.sh

# Expose ports for SSH and GDB
EXPOSE 22 7777
COPY start.sh /start.sh
COPY opt_setup.sh /opt_setup.sh
RUN chmod +x /start.sh /opt_setup.sh

# Add dev user with password dev
RUN useradd -ms /bin/bash dev
RUN echo 'dev:dev' | chpasswd
RUN echo 'root:root' | chpasswd

CMD ["/start.sh"]
