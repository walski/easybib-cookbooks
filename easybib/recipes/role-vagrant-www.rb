include_recipe 'ies::role-generic'
include_recipe 'ies-mysql'
include_recipe 'ies-mysql::dev'
include_recipe 'php-pdo_sqlite'

include_recipe 'ohai'
include_recipe 'php-xdebug'
include_recipe 'memcache'

include_recipe 'easybib::role-nginxapp-api'
include_recipe 'easybib::role-nginxapp'
include_recipe 'stack-service::role-gearmand'
include_recipe 'easybib::role-gearmanw'
include_recipe 'nodejs::npm'