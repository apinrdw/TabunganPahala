workers ENV.fetch('WEB_CONCURRENCY') { 1 }.to_i
threads ENV.fetch('MIN_THREADS') { 16 }.to_i, ENV.fetch('MAX_THREADS') { 16 }.to_i

preload_app!

rackup      DefaultRackup
port        ENV.fetch('PORT') { 3000 }.to_i
environment ENV.fetch('RAILS_ENV') { 'development' }

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    config = ActiveRecord::Base.configurations[Rails.env] ||
      Rails.application.config.database_configuration[Rails.env]
    ActiveRecord::Base.establish_connection(config)
  end

  @sidekiq_pid ||= spawn('bundle exec sidekiq -C ./config/sidekiq.yml')
end

plugin :tmp_restart
