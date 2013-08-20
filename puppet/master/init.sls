include:
{% if grains['osfullname'] in ('CentOS', 'RHEL') %}
  - epel
  - puppet.repo
{% endif %}
  - puppet.agent
  
puppet-server:
  pkg:
    - installed

puppetmaster:
  service:
    - running
    - enable: True
    - require:
      - pkg: puppet-server
      - file: puppet.conf

/etc/puppet/puppet.conf:
  file.managed:
    - source: salt://puppet/master/files/puppet.conf
    - require:
      - pkg: puppet-server
    - watch_in:
      - service: puppetmaster
      - service: puppet