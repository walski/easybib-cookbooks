node['deploy'].each do |application, deploy|
  case application
  when 'easybib'
    unless allow_deploy(application, 'easybib', 'nginxphpapp') or allow_deploy(application, 'easybib', 'housekeeping')
      Chef::Log.info("stack-easybib::deploy-easybib - #{application} skipped")
      next
    end

  else
    Chef::Log.info("stack-easybib::deploy-easybib - #{application} skipped")
    next
  end

  Chef::Log.info("deploy::#{application} - Deployment started as user: #{deploy[:user]} and #{deploy[:group]}")

  easybib_deploy application do
    deploy_data deploy
    app application
  end

  # clean up old config before migration
  file '/etc/nginx/sites-enabled/easybib.com.conf' do
    action :delete
    ignore_failure true
  end

  nginx_extras = if node.fetch('easybib', {}).fetch('nginx-app', {}).fetch('disable-404', {})
                   'log_not_found off;'
                 else
                   ''
                 end

  easybib_nginx application do
    cookbook 'stack-easybib'
    config_template 'easybib.com.conf.erb'
    nginx_extras nginx_extras
    notifies :reload, 'service[nginx]', :delayed
    notifies node['easybib-deploy']['php-fpm']['restart-action'], 'service[php-fpm]', :delayed
  end
end
