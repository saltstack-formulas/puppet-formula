# A lookup table for Puppet GPG keys & RPM URLs for various RedHat releases
{% set pkg = salt['grains.filter_by']({
  'CentOS-5': {
    'key': 'http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs',
    'key_hash': 'md5=339014f9b0517552c232501438f40b3d',
    'rpm': 'http://yum.puppetlabs.com/el/5/products/i386/puppetlabs-release-5-7.noarch.rpm',
  },
  'CentOS-6': {
    'key': 'http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs',
    'key_hash': 'md5=339014f9b0517552c232501438f40b3d',
    'rpm': 'http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm',
  },
}, 'osfinger') %}

# Completely ignore non-CentOS, non-RHEL systems
{% if grains['osfullname'] in ('CentOS', 'RHEL') %}
install_pubkey:
  file:
    - managed
    - name: /etc/pki/rpm-gpg/RPRPM-GPG-KEY-puppetlabs
    - source: {{ salt['pillar.get']('puppet:repo:pubkey', pkg.key) }}
    - source_hash:  {{ salt['pillar.get']('puppet:repo:pubkey_hash', pkg.key_hash) }}

install_rpm:
  pkg:
    - installed
    - sources:
      - rpm: {{ salt['pillar.get']('puppet:repo:rpm', pkg.rpm) }}
    - requires:
      - file: install_pubkey

{% if salt['pillar.get']('puppet:repo:disabled', False) %}
disable_puppet_repo:
  file:
    - sed
    - name: /etc/yum.repos.d/puppet.repo
    - limit: '^enabled'
    - before: 1
    - after: 0
{% endif %}
{% endif %}