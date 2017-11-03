httpd-install:
  pkg.installed:
    - names:
      - httpd
  file.managed:
    - name: /etc/httpd/conf/httpd.conf
    - source: salt://httpd/files/httpd.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        ServerName: controller

/etc/httpd/conf.d/wsgi-keystone.conf:
  file.managed:
    - source: salt://httpd/files/wsgi-keystone.conf

httpd-service:
  service.running:
    - name: httpd.service
    - enable: True
