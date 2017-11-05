rabbitmq-install:
  pkg.installed:
    - names:
      - rabbitmq-server

/mnt/openstack.sh:
  file.managed:
    - source: salt://openstack/files/openstack.sh
    - template: jinja
    - context:
        admin_token: {{ pillar['admin_token'] }}
        controller: {{ pillar['controller'] }}
        keystonepwd: {{ pillar['keystonepwd'] }}
        adminpwd: {{ pillar['adminpwd'] }}
        demopwd: {{ pillar['demopwd'] }}
        rabbitpwd: {{ pillar['rabbitpwd'] }}
        glancepwd: {{ pillar['glancepwd'] }}
        novapwd: {{ pillar['novapwd'] }}
        neutronpwd: {{ pillar['neutronpwd'] }}
        cinderpwd: {{ pillar['cinderpwd'] }}

rabbitmq-service:
  service.running:
    - name: rabbitmq-server.service
    - enable: True
  cmd.run:
    - name: chmod +x /mnt/openstack.sh && bash /mnt/openstack.sh rabbitmq
