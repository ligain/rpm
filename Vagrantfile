Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.provision "shell", inline: <<-SHELL
  yum install redhat-lsb-core wget gcc rpmdevtools rpm-build createrepo yum-utils -y
  dnf --enablerepo=PowerTools install libedit-devel -y
  
  # Download and unpack nginx
  wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm
  rpm -i nginx-1.14.1-1.el7_4.ngx.src.rpm
  
  # Download and unpack openssl
  cd /root/
  wget https://www.openssl.org/source/openssl-1.1.1d.tar.gz
  tar -xvf openssl-1.1.1d.tar.gz

  # Build package  
  yum-builddep /root/rpmbuild/SPECS/nginx.spec -y
  cp /vagrant/nginx.spec /root/rpmbuild/SPECS/
  rpmbuild -bb /root/rpmbuild/SPECS/nginx.spec

  # Install package
  yum localinstall /root/rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm -y

  # Start installed nginx
  systemctl start nginx
  systemctl status nginx

  # Create repo
  mkdir /usr/share/nginx/html/repo
  cp /root/rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm /usr/share/nginx/html/repo/
  wget http://www.percona.com/downloads/percona-release/redhat/0.1-6/percona-release-0.1-6.noarch.rpm -O /usr/share/nginx/html/repo/percona-release-0.1-6.noarch.rpm
  createrepo /usr/share/nginx/html/repo/

  # Update nginx config
  cp /vagrant/default.conf /etc/nginx/conf.d/default.conf
  nginx -s reload

  curl localhost/repo/

  # Setup repo config
  cp /vagrant/otus.repo /etc/yum.repos.d/

  yum repolist enabled | grep otus
  yum list | grep otus

  SHELL
end