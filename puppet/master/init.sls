{% from "puppet/package-map.jinja" import puppet with context %}

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
    - name: {{ master.service }}
    - enable: True
    - require:
      - pkg: puppet-server
      - file: /etc/puppet/puppet.conf.master

puppetmaster:
  grains.present:
    - value: true

/etc/puppet/puppet.conf.master:
  file.managed:
    - name: /etc/puppet/puppet.conf
    - source: salt://puppet/master/files/puppet.conf
    - require:
      - pkg: puppet-server
    - watch_in:
      - service: puppet-server
      - service: puppet_agent

