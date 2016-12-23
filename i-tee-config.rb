require 'yaml'

ITee::Application.configure do

  config.serve_static_assets = false
  config.i18n.fallbacks = true
  config.action_dispatch.x_sendfile_header = 'X-Sendfile'
  config.active_support.deprecation = :notify

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new


  configFile = { }

  # .yaml is recommended extensions, so let's use that
  if File.exist?('/etc/i-tee/config.yaml')
    configFile = YAML.load_file("/etc/i-tee/config.yaml")
  end


  # Administrator and manager usernames
  config.admins = configFile.key?('admins') ? configFile['admins'] : [ ]
  config.managers = configFile.key?('managers') ? configFile['managers'] : [ ]

  # hostname for rdp sessions
  config.rdp_host = configFile['rdp_host']

  # port prefix for rdp sessions
  config.rdp_port_prefix = '10'
  config.rdp_password_length = 14

   # determine how many instances are shown per page
  config.per_page=15

  # determine what layout to use
  config.default_skin = configFile.key?('skin') ? configFile['skin'] : 'EIK'
  config.skins = { }

  # place for temporal files like VM customization files
  config.run_dir = '/var/labs/run'

  # place for lab export / import jsons
  config.export_location= '/var/labs/exports'

  # envidonment for bash scripts executed by rails
  ENV['ENVIRONMENT']="#{ITee::Application.config.run_dir}/environment.sh"

  # Virtualbox user and command line for launching scripts
  config.cmd_perfix = 'sudo -Hu vbox'

  # Guacamole configuration
  if configFile.key?('guacamole')
    config.guacamole = {

      # Domain name set to Guacamole authentication cookie
      cookie_domain: configFile['guacamole'].key?('cookie_domain') ?
                     configFile['guacamole']['cookie_domain'] : '',

      # Guacamole username prefix
      user_prefix: configFile['guacamole'].key?('prefix') ?
                   configFile['guacamole']['prefix'] : 'dev',

      # Full url to Guacamole API endpoints (e.g. https://localhost/guacamole)
      url_prefix: configFile['guacamole']['url_prefix'],

      max_connections: 5,
      max_connections_per_user: 2
    }

    if configFile['guacamole'].key?('rdp_host')

      # I-Tee host used by Guacamole to connect to machines via RDP (e.g. localhost)
      config.guacamole[:rdp_host] = configFile['guacamole']['rdp_host']

    end
  end


  if configFile.key?('development') && configFile['development']

    # Code is not reloaded between requests
    config.cache_classes = false

    # Log level (defaults to :info)
    config.log_level = :debug

    # Full error reports are disabled and caching is turned on
    config.consider_all_requests_local       = true
    config.action_controller.perform_caching = false

  else

    # Code is not reloaded between requests
    config.cache_classes = true

    # Log level (defaults to :info)
    config.log_level = :info

    # Full error reports are disabled and caching is turned on
    config.consider_all_requests_local       = false
    config.action_controller.perform_caching = true

  end
end
