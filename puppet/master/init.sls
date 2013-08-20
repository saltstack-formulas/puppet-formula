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
  file.append:
    - text: |
      - [master]
      - certname = {{ salt['pillar.get']('puppet:master:certname', grains['fqdn']) }}
      - dns_alt_names = {{ salt['pillar.get']('puppet:master:dns_alt_names', puppet) }}
    - require:
      - pkg: puppet-server
    - watch_in:
      - service: puppetmaster
    