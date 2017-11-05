glance-install:
  pkg.installed:
    - names:
      - openstack-glance
  cmd.run:
    - name: bash /mnt/openstack.sh glance

/etc/glance/glance-api.conf:
  file.managed:
    - source: salt://openstack/files/glance-api.conf
    - template: jinja
    - context:
        controller: {{ pillar['controller'] }}
        glancepwd: {{ pillar['glancepwd'] }}

/etc/glance/glance-registry.conf:
  file.managed:
    - source: salt://openstack/files/glance-registry.conf
    - template: jinja
    - context:
        controller: {{ pillar['controller'] }}
        glancepwd: {{ pillar['glancepwd'] }}
glanceapi-service:
  service.running:
    - name: openstack-glance-api.service
    - enable: True

glancereg-service:
  service.running:
    - name: openstack-glance-registry.service
    - enable: True
