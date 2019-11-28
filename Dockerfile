FROM centos:7

WORKDIR /root/

RUN yum install redhat-lsb-core wget gcc rpmdevtools rpm-build createrepo yum-utils libedit-devel -y

RUN wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm && \
    rpm -i nginx-1.14.1-1.el7_4.ngx.src.rpm

RUN wget https://www.openssl.org/source/openssl-1.1.1d.tar.gz && \
    tar -xvf openssl-1.1.1d.tar.gz

COPY ./nginx.spec /root/rpmbuild/SPECS/
RUN yum-builddep /root/rpmbuild/SPECS/nginx.spec -y && rpmbuild -bb /root/rpmbuild/SPECS/nginx.spec

RUN yum localinstall /root/rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm -y

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# clean up
RUN rm -rf rpmbuild/ openssl-1.1.1d/ openssl-1.1.1d.tar.gz nginx-1.14.1-1.el7_4.ngx.src.rpm

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]