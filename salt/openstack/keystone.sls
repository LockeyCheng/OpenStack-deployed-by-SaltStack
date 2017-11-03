keystone-install:
  pkg.installed:
    - names:
      - openstack-keystone
      - mod_wsgi
  file.managed:
    - name: /etc/keystone/keystone.conf
    - source: salt://openstack/files/keystone.conf

/etc/admin-openrc:
  file.managed:
    - source: salt://openstack/files/admin-openrc

/etc/demo-openrc:
  file.managed:
    - source: salt://openstack/files/demo-openrc
  cmd.run:
    - name: su -s /bin/sh -c "keystone-manage db_sync" keystone && keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone && export OS_TOKEN=fcd02c873320be108d59 && export OS_URL=http://controller:35357/v3 && export OS_IDENTITY_API_VERSION=3 && openstack service create --name keystone --description "OpenStack Identity" identity && openstack endpoint create --region RegionOne identity public http://controller:5000/v3 && openstack endpoint create --region RegionOne identity internal http://controller:5000/v3 && openstack endpoint create --region RegionOne identity admin http://controller:35357/v3 && openstack domain create --description "Default Domain" default && openstack project create --domain default --description "Admin Project" admin
