include:
  - epel
  - puppet.agent
  - puppet.repo
  
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

/etc/puppet:
  file:
    - recurse
    - source: salt://puppet/master/files
    - template: jinja
    - require:
      - pkg: puppet-server
    - watch_in:
      - service: puppetmaster
    