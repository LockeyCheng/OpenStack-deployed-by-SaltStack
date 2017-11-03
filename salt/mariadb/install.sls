mariadb-install:
  pkg.installed:
    - names:
      - mariadb-server
      - mariadb
      - python2-PyMySQL
  file.managed:
    - name: /etc/my.cnf.d/openstack.cnf
    - source: salt://mariadb/files/openstack.cnf

mariadb-service:
  service.running:
    - name: mariadb.service 
    - enable: True
