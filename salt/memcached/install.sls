memcached-install:
  pkg.installed:
    - names:
      - memcached
      - python-memcached
  file.managed:
    - name: /etc/sysconfig/memcached
    - source: salt://memcached/files/memcached
    - user: root
    - group: root
    - mode: 644

memcached-service:
  service.running:
    - name: memcached.service
    - enable: True
