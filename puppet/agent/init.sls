include:
  - puppet.repo

puppet:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - require:
      - pkg: puppet

/etc/puppet
  - recurse
  - source: salt://puppet/agent/files
  - template: jinja
  - require:
    - pkg: puppet
  - watch_in:
    - service: puppet