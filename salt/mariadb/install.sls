mariadb-install:
  pkg.installed:
    - names:
      - mariadb-server
      - mariadb
      - python2-PyMySQL
  file.managed:
    - name: /etc/my.cnf.d/openstack.cnf
    - source: salt://mariadb/files/openstack.cnf
    - mode: 644
    - template: jinja
    - context:
        ip: {{ pillar['myip'] }}

mariadb-service:
  service.running:
    - name: mariadb.service
    - enable: True
  cmd.run:
    - name: chmod +x /mnt/openstack.sh && bash /mnt/openstack.sh mariadb
