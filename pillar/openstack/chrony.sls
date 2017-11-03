{% if grains['host'] == 'ok-vm2' %}
server: 'controller'
allow: 'allow 192.168/16'
{% else %}
server: 'time1.aliyun.com'
allow: 'allow 192.168/16'
{% endif %}
