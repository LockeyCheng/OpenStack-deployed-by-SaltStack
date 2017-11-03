include:
  - mariadb.install

mariadb-exec:
  cmd.run:
    - name: sleep 5 && /usr/bin/mysqladmin -u root password redhat; mysql -uroot -predhat -e "create database keystone; grant all on keystone.* to keystone@'localhost' identified by 'keystone'; grant all on keystone.* to keystone@'%' identified by 'keystone'; create database glance; grant all on glance.* to glance@'localhost' identified by 'glance'; grant all on glance.* to glance@'%' identified by 'glance'; create database nova; CREATE DATABASE nova_api; grant all on nova.* to nova@'localhost' identified by 'nova'; grant all on nova.* to nova@'%' identified by 'nova'; GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'localhost' IDENTIFIED BY 'nova'; GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'%' IDENTIFIED BY 'nova'; create database neutron; grant all on neutron.* to neutron@'localhost' identified by 'neutron'; grant all on neutron.* to neutron@'%' identified by 'neutron'; create database cinder; grant all on cinder.* to cinder@'localhost' identified by 'cinder'; grant all on cinder.* to cinder@'%' identified by 'cinder';" 
