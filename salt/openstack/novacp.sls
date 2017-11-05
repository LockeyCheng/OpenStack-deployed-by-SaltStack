novacp-install:
  pkg.installed:
    - names:
       - openstack-nova-compute
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://openstack/files/novacp.conf
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

novacp-service:
    service.running:
    - names:
      - libvirtd.service
      - openstack-nova-compute.service
    - enable: True
