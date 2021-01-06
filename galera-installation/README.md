# Migrate a Mysql database to Galera cluster
First step is to install some requirments.

`yum install rsync policycoreutils-python`

Next we should remove previous Mysql database engine and install new one which has `wsrep` API. To do this we add `galera.repo` and start installing.

`vim /etc/yum.repos.d/galera.repo`

```[galera]

name = Galera

baseurl = https://releases.galeracluster.com/galera-3/centos/7/x86_64

gpgkey = https://releases.galeracluster.com/GPG-KEY-galeracluster.com

gpgcheck = 1

[mysql-wsrep]

name = MySQL-wsrep

baseurl =  https://releases.galeracluster.com/mysql-wsrep-5.7/centos/7/x86_64/

gpgkey = https://releases.galeracluster.com/GPG-KEY-galeracluster.com

gpgcheck = 1
```

`yum remove mysql`

`yum remove mysql-community-common`

Now we can install new Mysql engine.

`yum install galera-3 mysql-wsrep-5.7`

Note that here we install Mysql version 5.7

Next open firewall ports.

`firewall-cmd --add-port={3306,4567,4568,4444}/tcp --permanent; firewall-cmd --reload`

At this time we need to edit Mysql configuration so edit `/etc/my.cnf` and add below content.

`vim /etc/my.cnf`

`[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
user=mysql
binlog_format=ROW
bind-address=0.0.0.0
default_storage_engine=innodb
innodb_autoinc_lock_mode=2
innodb_flush_log_at_trx_commit=0
innodb_buffer_pool_size=122M
wsrep_provider=/usr/lib64/galera-3/libgalera_smm.so
wsrep_provider_options="gcache.size=300M; gcache.page_size=300M"
wsrep_cluster_name="art"
wsrep_cluster_address="gcomm://192.168.0.9,192.168.0.71"
wsrep_sst_method=rsync

wsrep_node_address="192.168.0.71"
wsrep_node_name="master1"

log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid`

Consider about below lines:

In `wsrep_cluster_address` you should change IP addresses with correct values.

In `wsrep_cluster_name` you should add you desired name for database cluster.

And these two below lines should be edited based on node informataion.

`wsrep_node_address="192.168.0.71"
wsrep_node_name="master1"`

Now it is time to initialize the cluster. To do this in first node of claster do below steps.

Important note: below steps should be done if you want to migrate an existing database to Galera. For clean installation below steps are not needed.

`systemctl set-environment MYSQLD_OPTS="--wsrep_on=OFF"`

`systemctl start mysqld`

`mysql_upgrade -p`

`systemctl unset-environment MYSQLD_OPTS`

Now for last step we should initialize the cluster.

`systemctl set-environment MYSQLD_OPTS="--wsrep-new-cluster"`

`systemctl start mysqld`

`systemctl unset-environment MYSQLD_OPTS`

# Crucial note: 

Only use `systemctl set-environment MYSQLD_OPTS="--wsrep-new-cluster"` for the first time and after that do not use this option again neither for first node nor other nodes.`

In order to join other nodes to cluster just install new Mysql engine with `wsrep` API and edit `/etc/my.cnf` as described earlier in this article and start Mysql service normally.

`systemctl start mysqld`
