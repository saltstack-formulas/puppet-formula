{% from "puppet/map.jinja" import puppet with context %}
{% set puppetmaster = salt['grains.get']('puppetmaster', False) %}

{% if grains['osfullname'] in ('CentOS', 'RHEL') %}
include:
  - epel
  - puppet.repo
{% endif %}

puppet_agent:
  pkg.installed:
    - name: {{ puppet.agent }}
  service.running:
    - name: {{ puppet.agentservice }}
    - enable: True
    - require:
      - pkg: puppet
      {% if puppetmaster == True %}  
      - file: /etc/puppet/puppet.conf.master
      {% else %}
      - file: /etc/puppet/puppet.conf.agent
      {% endif %}

{% if puppetmaster == False %}
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
    - value: True
