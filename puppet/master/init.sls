include:
{% if grains['osfullname'] in ('CentOS', 'RHEL') %}
  - epel
  - puppet.repo
{% endif %}
  - puppet.agent


puppet-server:
  pkg.installed:
{% if grains['osfullname'] in ('CentOS', 'RHEL') %}  
    - name: puppet-server      
{% elif grains['osfullname'] in ('Debian', 'Ubuntu') %}
    - name: puppetmaster
{% endif %}    
  service.running:
    - name: puppetmaster
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
      - service: puppetmaster
      - service: puppet

