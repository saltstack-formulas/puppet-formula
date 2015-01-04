{% from "puppet/map.jinja" import puppet with context %}

include:
{% if grains['osfullname'] in ('CentOS', 'RHEL') %}
  - epel
  - puppet.repo
{% endif %}
  - puppet.agent


puppet-server:
  pkg.installed:
    - name: {{ puppet.server }}      
  service.running:
    - name: {{ puppet.masterservice }}
    - enable: True
    - require:
      - pkg: puppet-server
      - file: /etc/puppet/puppet.conf.master

puppetmaster:
  grains.present:
    - value: True

/etc/puppet/puppet.conf.master:
  file.managed:
    - name: /etc/puppet/puppet.conf
    - template: jinja
    - source: salt://puppet/master/files/puppet.conf
    - require:
      - pkg: puppet-server
    - watch_in:
      - service: puppet-server
      - service: puppet_agent

