default["nginx-app"]                      = {}
default["nginx-app"][:user]               = "www-data"
default["nginx-app"][:group]              = "www-data"
default["nginx-app"][:static_directories] = ["js", "css", "images", "raw"]
default["nginx-app"][:config_dir]         = "/etc/nginx"

# module specific configuration for assets
default["nginx-app"][:js_modules] = {
    "debugger"        => "debugger",
    "notes"           => "notebook",
    "cms"             => "cms",
    "bibanalytics"    => "bibanalytics",
    "sharing"         => "sharing",
    "kb"              => "kb",
    "infolit"         => "infolit",
    "schoolanalytics" => "schoolanalytics",
    "students"        => "students",
    "pearson"         => "pearson",
    "folders"         => "folders"
}
default["nginx-app"][:img_modules] = {
    "notes"     => "notebook",
    "outline"   => "notebook",
    "paperlink" => "paperlink",
    "infolit"   => "infolit",
    "braintree" => "braintree",
    "pearson"   => "pearson",
    "folders"   => "folders"
}
default["nginx-app"][:css_modules] = {
    "debugger"        => "debugger",
    "notes"           => "notebook",
    "cms"             => "cms",
    "bibanalytics"    => "bibanalytics",
    "sharing"         => "sharing",
    "kb"              => "kb",
    "infolit"         => "infolit",
    "schoolanalytics" => "schoolanalytics",
    "braintree"       => "braintree",
    "pearson"         => "pearson",
    "folders"         => "folders"
}

# Silverline attribs
default[:silverline][:nginx_name] = "nginx"
