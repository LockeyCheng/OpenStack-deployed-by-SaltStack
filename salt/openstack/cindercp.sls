cindercp-install:
  pkg.installed:
    - names:
       - lvm2
       - openstack-cinder
       - targetcli
       - python-keystone
  cmd.run:
    - name: systemctl enable lvm2-lvmetad.service && systemctl start lvm2-lvmetad.service && pvcreate /dev/sdb && vgcreate cinder-volumes /dev/sdb

/etc/lvm/lvm.conf:
  file.managed:
    - source: salt://openstack/files/lvm.conf
    - template: jinja
    - context:
        systemdev: {{ pillar['systemdev'] }}
        cinderdev: {{ pillar['cinderdev'] }}

/etc/cinder/cinder.conf:
  file.managed:
    - source: salt://openstack/files/cindercp.conf
    - template: jinja
    - context:
        controller: {{ pillar['controller'] }}
        rabbitpwd: {{ pillar['rabbitpwd'] }}
        cinderpwd: {{ pillar['cinderpwd'] }}
        ip: {{ pillar['myip'] }}

cindercp-service:
    service.running:
    - names:
      - openstack-cinder-volume.service
      - target.service
    - enable: True
