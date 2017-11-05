neutroncp-install:
  pkg.installed:
    - names:
       - openstack-neutron-linuxbridge
       - ebtables
       - ipset
  file.managed:
    - name: /etc/neutron/neutron.conf
    - source: salt://openstack/files/neutroncp.conf
    - mode: 644
    - template: jinja
    - context:
        controller: {{ pillar['controller'] }}
        novapwd: {{ pillar['novapwd'] }}
        rabbitpwd: {{ pillar['rabbitpwd'] }}
        neutronpwd: {{ pillar['neutronpwd'] }}

/etc/neutron/plugins/ml2/linuxbridge_agent.ini:
  file.managed:
    - source: salt://openstack/files/linuxbridge_agent.ini
    - mode: 644
    - template: jinja
    - context:
      interface: {{ pillar['interface'] }}
  cmd.run:
    - name: systemctl restart openstack-nova-compute.service


neutroncp-service:
    service.running:
    - names: 
      - neutron-linuxbridge-agent.service
    - enable: True 
