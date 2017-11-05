cinderctl-install:
  pkg.installed:
    - names:
       - openstack-cinder
  file.managed:
    - name: /etc/cinder/cinder.conf
    - source: salt://openstack/files/cinderctl.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
      controller: {{ pillar['controller'] }}
      cinderpwd: {{ pillar['cinderpwd'] }}
      rabbitpwd: {{ pillar['rabbitpwd'] }}
      ip: {{ pillar['myip'] }}
  cmd.run:
    - name: bash /mnt/openstack.sh cinder

cinderctl-service:
    service.running:
    - names:
      - openstack-cinder-api.service
      - openstack-cinder-scheduler
    - enable: True
