#!/bin/bash

########## Check Root access ##########
if [[ $EUID -ne 0 ]]; then
    echo -e "\033[0;31mThis Script Must Be Run As Root! \033[0m"
    exit 1
fi

# This is script compile and install Nginx 1.18 from source
# with vhost traffic status 

# Get server IP and server name
read -p "Please enter server IP address: " SERVER_IP
read -p "Please enter server name: " SERVER_NAME

# Install some dependencies
yum -y install gd gd-devel libxslt-devel perl-ExtUtils-Embed gperftools-devel gcc git yumutils autoconf automake build-essential libcurl4-openssl-dev libgeoip-dev liblmdb-dev libpcre++-dev libtool libxml2-dev libyajl-dev pkgconf wget zlib1g-dev gcc-c++ pcre-devel redhat-rpm-config openssl openssl-devel

# Change direcory to /tmp and clone Nginx, vhost status and modsecurity source
cd /tmp
wget http://nginx.org/download/nginx-1.18.0.tar.gz
git clone git://github.com/vozlt/nginx-module-vts.git
tar xf nginx-1.18.0.tar.gz
cd nginx-1.18.0/
./configure  --with-compat --prefix=/usr/share/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib64/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --http-client-body-temp-path=/var/lib/nginx/tmp/client_body --http-proxy-temp-path=/var/lib/nginx/tmp/proxy --http-fastcgi-temp-path=/var/lib/nginx/tmp/fastcgi --http-uwsgi-temp-path=/var/lib/nginx/tmp/uwsgi --http-scgi-temp-path=/var/lib/nginx/tmp/scgi --pid-path=/run/nginx.pid --lock-path=/run/lock/subsys/nginx --user=nginx --group=nginx --with-file-aio --with-ipv6 --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-stream_ssl_preread_module --with-http_addition_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --with-http_perl_module=dynamic --with-http_auth_request_module --with-mail=dynamic --with-mail_ssl_module --with-pcre --with-pcre-jit --with-stream=dynamic --with-stream_ssl_module --with-google_perftools_module --with-debug --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -m64 -mtune=generic' --with-ld-opt='-Wl,-z,relro -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -Wl,-E' --add-dynamic-module=../nginx-module-vts/

make
make install

# Create the NGINX system user and group
useradd --system --home /var/cache/nginx --shell /sbin/nologin --comment "nginx user" --user-group nginx

# Create below directory
mkdir -p /var/lib/nginx/tmp/client_body

# Create a systemd unit file for nginx
cp /root/nginx-vts-installation/nginx.service /usr/lib/systemd/system/

# Nginx vts installation commands
cd /tmp
wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz
tar -xvf go1.15.2.linux-amd64.tar.gz
mv go /usr/local/

# Set GOROOT and GOTPATH variables
mkdir -p nginx-vts/bin
export GOPATH=/tmp/nginx-vts
export GOROOT=/usr/local/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Clone vts source code
wget https://github.com/hnlq715/nginx-vts-exporter/archive/v0.10.7.tar.gz
tar xf v0.10.7.tar.gz
cd nginx-vts-exporter-0.10.7/
go install nginx_vts_exporter.go

# Copy executaion file in /usr/local/bin and create user for vts service
cp $GOPATH/bin/nginx_vts_exporter /usr/local/bin
useradd --no-create-home --shell /bin/false nginx_vts_exporter

# Create a service for vts
cp /root/nginx-vts-installation/nginx_vts_exporter.service /etc/systemd/system/
sed -i "s/SERVER_IP/$SERVER_IP/g" /etc/systemd/system/nginx_vts_exporter.service

# Now start nginx and vts service
systemctl daemon-reload; systemctl enable nginx nginx_vts_exporter; systemctl start nginx nginx_vts_exporter; systemctl status nginx nginx_vts_exporter

# Now we should create "/usr/share/nginx/modules/" directory and copy Nginx virtual host traffic status and ModSecurity modules to there
mkdir -p /usr/share/nginx/modules/
cp /tmp/nginx-1.18.0/objs/ngx_http_vhost_traffic_status_module.so /usr/share/nginx/modules/

# Copy nginx configuration files
openssl dhparam -out /etc/nginx/dhparam.pem 2048
mkdir /etc/nginx/conf.d
cp /root/nginx-vts-installation/nginx.conf /etc/nginx/
cp /root/nginx-vts-installation/status.conf /etc/nginx/conf.d/
sed -i "s/SERVER_IP/$SERVER_IP/g" /etc/nginx/conf.d/status.conf
sed -i "s/SERVER_NAME/$SERVER_NAME/g" /etc/nginx/conf.d/status.conf

# Reload Nginx to load new configuration files
nginx -s reload
