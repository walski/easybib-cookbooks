name              'ies'
maintainer        'Till Klampaeckel'
maintainer_email  'till@php.net'
license           'BSD License'
description       'Our generic setup and install scripts across all stacks'
version           '0.1'
recipe            'ies::role-generic', 'Generic setup for all our instances'
recipe            'ies::setup-sns', 'Set up SNS notifications for our instances'

supports 'ubuntu'

depends 'apt'
depends 'chef_handler_sns'
depends 'easybib'
depends 'fail2ban'
depends 'ies-route53'
depends 'loggly'
depends 'monit'
depends 'postfix'
depends 'rsyslogd'
