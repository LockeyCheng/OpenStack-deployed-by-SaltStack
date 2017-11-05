keystone-install:
  pkg.installed:
    - names:
      - openstack-keystone
      - httpd
      - mod_wsgi
  file.managed:
    - name: /etc/keystone/keystone.conf
    - source: salt://openstack/files/keystone.conf
    - mode: 644
    - template: jinja
    - context:
        admin_token: {{ pillar['admin_token'] }}
        controller: {{ pillar['controller'] }}
        keystonepwd: {{ pillar['keystonepwd'] }}

/etc/httpd/conf/httpd.conf:
  file.managed:
    - source: salt://openstack/files/httpd.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        ServerName: controller

/etc/httpd/conf.d/wsgi-keystone.conf:
  file.managed:
    - source: salt://openstack/files/wsgi-keystone.conf

/mnt/admin-openrc:
  file.managed:
    - source: salt://openstack/files/admin-openrc
    - template: jinja
    - context:
        adminpwd: {{ pillar['adminpwd'] }}
        controller: {{ pillar['controller'] }}


/mnt/demo-openrc:
  file.managed:
    - source: salt://openstack/files/demo-openrc
    - template: jinja
    - context:
        demopwd: {{ pillar['demopwd'] }}
        controller: {{ pillar['controller'] }}

httpd-service:
  service.running:
    - name: httpd.service
    - enable: True
  cmd.run:
    - name: bash /mnt/openstack.sh keystone
