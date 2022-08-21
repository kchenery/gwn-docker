FROM centos:centos7
ARG SOURCE_URL=http://www.grandstream.com/hubfs/IoT%20Team/GWN_Manager-1.0.22.23.tar.gz

RUN yum -y update
RUN yum -y install epel-release sysvinit-tools jemalloc libaio glibc-devel fontconfig xorg-x11-font-utils freetype curl openssl

RUN curl $SOURCE_URL --output GWN_Manager.tar.gz
RUN tar -xvzf ./GWN_Manager.tar.gz
RUN rm ./GWN_Manager.tar.gz
RUN yum -y install ./gwn*.rpm

COPY conf/local_env.cfg /gwn/conf/gwn/local_env.cfg
COPY conf/gwn.conf      /gwn/conf/gwn.conf
COPY conf/my.cnf        /gwn/conf/mysql/my.cnf
COPY conf/nginx.conf    /gwn/conf/nginx/nginx.conf
COPY conf/redis.conf    /gwn/conf/redis/redis.conf

RUN chown -R gwn:gwn /gwn/conf/*
RUN chmod -R a+r /gwn/conf/*

COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

#EXPOSE 8443
EXPOSE 8000
EXPOSE 10014

ENTRYPOINT [ "/entrypoint.sh" ]