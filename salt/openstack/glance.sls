glance-install:
  pkg.installed:
    - names:
      - openstack-glance
  file.managed:
    - name: /etc/glance/glance-api.conf
    - source: salt://openstack/files/glance-api.conf
