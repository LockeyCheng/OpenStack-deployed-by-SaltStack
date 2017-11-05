#!/bin/bash

option=$1
case $option in

  'mariadb')
echo 'mariadb'>>/mnt/halo
/usr/bin/mysqladmin -u root password redhat
mysql -uroot -predhat -e "create database keystone; grant all on keystone.* to keystone@'localhost' identified by '{{ keystonepwd }}'; grant all on keystone.* to keystone@'%' identified by '{{ keystonepwd }}'; create database glance; grant all on glance.* to glance@'localhost' identified by '{{ glancepwd }}'; grant all on glance.* to glance@'%' identified by '{{ glancepwd }}'; create database nova; CREATE DATABASE nova_api; grant all on nova.* to nova@'localhost' identified by '{{ novapwd }}'; grant all on nova.* to nova@'%' identified by '{{ novapwd }}'; GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'localhost' IDENTIFIED BY '{{ novapwd }}'; GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'%' IDENTIFIED BY '{{ novapwd }}'; create database neutron; grant all on neutron.* to neutron@'localhost' identified by '{{ neutronpwd }}'; grant all on neutron.* to neutron@'%' identified by '{{ neutronpwd }}'; create database cinder; grant all on cinder.* to cinder@'localhost' identified by '{{ cinderpwd }}'; grant all on cinder.* to cinder@'%' identified by '{{ cinderpwd }}';"
	;;

	'rabbitmq')
echo 'rabbitmq'>>/mnt/halo
rabbitmqctl add_user openstack {{ rabbitpwd }}
rabbitmqctl set_permissions openstack ".*" ".*" ".*"
rabbitmq-plugins enable rabbitmq_management
  ;;

	'keystone')
export OS_TOKEN={{ admin_token }}
export OS_URL=http://{{ controller }}:35357/v3
export OS_IDENTITY_API_VERSION=3
echo 'keystone'>>/mnt/halo
su -s /bin/sh -c "keystone-manage db_sync" keystone
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
openstack service create   --name keystone --description "OpenStack Identity" identity
openstack endpoint create --region RegionOne identity public http://{{ controller }}:5000/v3
openstack endpoint create --region RegionOne identity internal http://{{ controller }}:5000/v3
openstack endpoint create --region RegionOne identity admin http://{{ controller }}:35357/v3
openstack domain create --description "Default Domain" default
openstack project create --domain default --description "Admin Project" admin
openstack user create --domain default --password admin {{ adminpwd }}
openstack role create admin
openstack role add --project admin --user admin admin
openstack project create --domain default --description "Service Project" service
openstack project create --domain default --description "Demo Project" demo
openstack user create --domain default --password demo {{ demopwd }}
openstack role create user
openstack role add --project demo --user demo user
;;

	'glance')

echo 'glance'>>/mnt/halo
source /mnt/admin-openrc
openstack user create --domain default --password glance {{ glancepwd }}
openstack role add --project service --user glance admin
openstack service create --name glance   --description "OpenStack Image" image
openstack endpoint create --region RegionOne   image public http://{{ controller }}:9292
openstack endpoint create --region RegionOne   image internal http://{{ controller }}:9292
openstack endpoint create --region RegionOne   image admin http://{{ controller }}:9292
su -s /bin/sh -c "glance-manage db_sync" glance
		;;

		'nova')

echo 'nova' >>/mnt/halo
source /mnt/admin-openrc
openstack user create --domain default --password nova {{ novapwd }}
openstack role add --project service --user nova admin
openstack service create --name nova --description "OpenStack Compute" compute
openstack endpoint create --region RegionOne   compute public http://{{ controller }}:8774/v2.1/%\(tenant_id\)s
openstack endpoint create --region RegionOne   compute internal http://{{ controller }}:8774/v2.1/%\(tenant_id\)s
openstack endpoint create --region RegionOne   compute admin http://{{ controller }}:8774/v2.1/%\(tenant_id\)s
su -s /bin/sh -c "nova-manage api_db sync" nova
su -s /bin/sh -c "nova-manage db sync" nova
		;;

		'neutron')

echo 'neutron' >>/mnt/halo
source /mnt/admin-openrc
openstack user create --domain default --password neutron {{ neutronpwd }}
openstack role add --project service --user neutron admin
openstack service create --name neutron   --description "OpenStack Networking" network
openstack endpoint create --region RegionOne   network public http://{{ controller }}:9696
openstack endpoint create --region RegionOne   network internal http://{{ controller }}:9696
openstack endpoint create --region RegionOne   network admin http://{{ controller }}:9696
ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini
su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron
systemctl restart openstack-nova-api.service
		;;
		'cinder')
echo 'cinder'>>/mnt/halo
source /mnt/admin-openrc
openstack user create --domain default --password cinder {{ cinderpwd }}
openstack role add --project service --user cinder admin
openstack service create --name cinder --description "OpenStack Block Storage" volume
openstack service create --name cinderv2 --description "OpenStack Block Storage" volumev2
openstack endpoint create --region RegionOne volume public http://{{ controller }}:8776/v1/%\(tenant_id\)s
openstack endpoint create --region RegionOne volume internal http://{{ controller }}:8776/v1/%\(tenant_id\)s
openstack endpoint create --region RegionOne volume admin http://{{ controller }}:8776/v1/%\(tenant_id\)s
openstack endpoint create --region RegionOne volumev2 public http://{{ controller }}:8776/v2/%\(tenant_id\)s
openstack endpoint create --region RegionOne volumev2 internal http://{{ controller }}:8776/v2/%\(tenant_id\)s
openstack endpoint create --region RegionOne volumev2 admin http://{{ controller }}:8776/v2/%\(tenant_id\)s
su -s /bin/sh -c "cinder-manage db sync" cinder
systemctl restart openstack-nova-api.service
		;;
	 *)
		echo 'default'>>/mnt/halo
		;;

esac
