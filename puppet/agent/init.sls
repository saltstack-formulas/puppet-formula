{% if grains['osfullname'] in ('CentOS', 'RHEL') %}
include:
  - epel
  - puppet.repo
{% endif %}

puppet:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - require:
      - pkg: puppet
      {% if grains['puppetmaster'] == true %}  
      - file: /etc/puppet/puppet.conf.master
      {% else %}
      - file: /etc/puppet/puppet.conf.agent
      {% endif %}

{% if grains['puppetmaster'] == false %}
/etc/puppet/puppet.conf.agent:
  file.managed:
  - name: /etc/puppet/puppet.conf
  - source: salt://puppet/agent/files/puppet.conf
  - template: jinja
  - require:
    - pkg: puppet
  - watch_in:
    - service: puppet
{% endif %}

puppetagent:
  grains.present:
    - value: true