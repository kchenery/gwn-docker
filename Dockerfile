FROM ubuntu:24.04
ARG SOURCE_URL=https://firmware.grandstream.com/GWN_Manager-1.1.28.27-Ubuntu.tar.gz

# Dependencies
RUN apt-get update && \
    apt-get install -y \
        curl \
        openssh-server \
        tar \
        xfonts-utils \
        fontconfig \
        iproute2 && \
    mkdir /tmp/gwn-install && \
    curl -sSL $SOURCE_URL | tar -xvzf - -C /tmp/gwn-install --strip-components=1 && \
    cd /tmp/gwn-install && \
    ./install && \
    sed -i 's/^access_address=.*/access_address=0.0.0.0/' /gwn/conf/gwn.conf && \
    rm -rf /tmp/gwn-install && \
    apt-get remove -y curl && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000 8443 10014

ENTRYPOINT [ "/entrypoint.sh" ]