dashboard-install:
  pkg.installed:
    - names:
      - openstack-dashboard
  file.managed:
    - name: /etc/openstack-dashboard/local_settings
    - source: salt://openstack/files/local_settings
    - mode: 644
    - template: jinja
    - context:
        controller: {{ pillar['controller'] }}
  cmd.run:
    - name: systemctl restart httpd.service memcached.service
