puppet-formula
==============

Single Server puppet Deployment

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/topics/conventions/formulas.html>`_.

Available states
----------------

``puppet``
    Installs puppet master and puppet agent
``puppet.agent``
    Installs puppet agent
``puppet.master``
    Installs puppet master
``puppet.repo``
    Installs puppetlabs repo on Centos/RHel

These formulas depend on the following formulas:

* `epel <https://github.com/saltstack-formulas/epel-formula>`_    