package "htop"
package "jwhois"
package "multitail"
package "apache2-utils"
package "strace"
package "rsync"
package "manpages"
package "manpages-dev"
package "nscd"
package "subversion"
package "git-core"
package "unzip"

include_recipe "easybib-base::awscommand"
include_recipe "easybib-base::nginxstats"
include_recipe "easybib-base::cron"

# landscape is buggy
# https://bugs.launchpad.net/ubuntu/+source/pam/+bug/805423
package "landscape-client" do
  action :purge
end
