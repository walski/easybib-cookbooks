actions :create, :delete

default_action :create

attribute :app, :default => ''
attribute :crontab_file, :kind_of => String, :default => ''
attribute :instance_roles, :default => []
attribute :cronjob_role, :kind_of => String, :default => nil
attribute :crontab_user, :kind_of => String, :default => nil
