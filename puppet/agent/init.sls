{% from "puppet/map.jinja" import puppet with context %}

{% if grains['osfullname'] in ('CentOS', 'RHEL') %}
include:
  - epel
  - puppet.repo
{% endif %}

puppet_agent:
  pkg:
    - installed
    - name: {{ puppet.agent }}
  service:
    - name: {{ agent.service }}
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
    - pkg: puppet_agent
  - watch_in:
    - service: puppet_agent
{% endif %}

puppetagent:
  grains.present:
    - value: true
