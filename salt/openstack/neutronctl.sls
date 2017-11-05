neutronctl-install:
  pkg.installed:
    - names:
       - openstack-neutron 
       - openstack-neutron-ml2
       - openstack-neutron-linuxbridge
       - ebtables
  file.managed:
    - name: /etc/neutron/neutron.conf
    - source: salt://openstack/files/neutronctl.conf
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

/etc/neutron/plugins/ml2/ml2_conf.ini:
  file.managed:
    - source: salt://openstack/files/ml2_conf.ini

/etc/neutron/dhcp_agent.ini:
  file.managed:
    - source: salt://openstack/files/dhcp_agent.ini
  cmd.run:
    - name: bash /mnt/openstack.sh neutron

neutron-service:
    service.running:
    - names: 
      - neutron-server.service
      - neutron-linuxbridge-agent.service
      - neutron-dhcp-agent.service
      - neutron-metadata-agent.service
    - enable: True  
