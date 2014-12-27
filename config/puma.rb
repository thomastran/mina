workers Integer(ENV['PUMA_WORKERS'] || 3)
threads Integer(ENV['MIN_THREADS']  || 1), Integer(ENV['MAX_THREADS'] || 16)

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 9000
environment ENV['RACK_ENV'] || 'development'

daemonize true

pidfile "/var/www/myapp/shared/tmp/pids/puma.pid"
stdout_redirect "/var/www/myapp/shared/tmp/log/stdout", "/var/www/myapp/shared/tmp/log/stderr"

bind "unix:///var/www/myapp/shared/tmp/sockets/puma.sock"

on_worker_boot do
  # worker specific setup
  ActiveSupport.on_load(:active_record) do
    config = ActiveRecord::Base.configurations[Rails.env] ||
                Rails.application.config.database_configuration[Rails.env]
    config['pool'] = ENV['MAX_THREADS'] || 16
    ActiveRecord::Base.establish_connection(config)
  end
end
