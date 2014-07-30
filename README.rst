puppet-formula
==============

Salt puppet Deployment:  
 - puppet agent  
 - puppet master  
 - both  

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``puppet``
----------

Installs puppet master and puppet agent

``puppet.agent``
----------------

Installs puppet agent

``puppet.master``
-----------------

Installs puppet master

``puppet.repo``
---------------

Installs puppetlabs repo on Centos/RHel

Formula Dependencies
====================

* `epel <https://github.com/saltstack-formulas/epel-formula>`_

Pillar
======

In pillar the following items can be set:

.. contents::
    :local:

``logdir``
----------

logdir location
      
``rundir``
----------

rundir location

``server``
----------

which puppet server should the agent use

``report``
----------

should the puppet agent report to master

``pluginsync``
--------------

should the puppet agent use pluginsync

``certname``
------------

what is the certificate name of the agent/master

``dns_alt_names``
-----------------

under which dns aliasses is the puppet master reachable
