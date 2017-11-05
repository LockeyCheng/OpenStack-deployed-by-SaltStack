novactl-install:
  pkg.installed:
    - names:
       - openstack-nova-api
       - openstack-nova-conductor
       - openstack-nova-console
       - openstack-nova-novncproxy
       - openstack-nova-scheduler
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://openstack/files/novactl.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
      controller: {{ pillar['controller'] }}
      novapwd: {{ pillar['novapwd'] }}
      rabbitpwd: {{ pillar['rabbitpwd'] }}
      neutronpwd: {{ pillar['neutronpwd'] }}
      metadataSecret: {{ pillar['metadatapwd'] }}
      ip: {{ pillar['myip'] }}
  cmd.run:
    - name: bash /mnt/openstack.sh nova

novactl-service:
    service.running:
    - names:
      - openstack-nova-api.service
      - openstack-nova-consoleauth.service
      - openstack-nova-scheduler.service
      - openstack-nova-conductor.service
      - openstack-nova-novncproxy.service
    - enable: True
