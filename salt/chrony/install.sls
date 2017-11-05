chronyd-install:
  pkg.installed:
    - names:
      - chrony
  file.managed:
    - name: /etc/chrony.conf
    - source: salt://chrony/files/chrony.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        timeServer: {{ pillar['timeserver'] }}
        allowClient: {{ pillar['allow'] }}
  cmd.run:
    - name: yum upgrade -y && yum -y install python-openstackclient
chronyd-service:
  service.running:
    - name: chronyd.service
    - enable: True
