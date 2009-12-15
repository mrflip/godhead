YUPFRONT_ROOT = "/var/www/yuploader"

# ===========================================================================
#
# A worker daemon watching a starling queue
#
group_options = { :monitor_group => :yupshot, :stop_notify => :only_flip, :flapping_notify => :only_flip }

Godhead::MemcachedRecipe.create     group_options.merge({
    :user => 'www-data', :pid_file => '/tmp/mc.pid'})
Godhead::StarlingRecipe.create      group_options
Godhead::GenericWorkerRecipe.create group_options.merge({
    :runner_path => "#{YUPFRONT_ROOT}/yupshot/bin/yupshot_worker_daemon" })

# ===========================================================================
#
# The frontend server that accepts jobs and inserts them into the queue
#
group_options = { :monitor_group => :yupfront , :flapping_notify => :default }}

# nginx front end
# if nginx feeds backend servers for many different projects, move it to its own file
Godhead::NginxRunnerRecipe.create group_options.merge({ })

# thin runs clients
(5000..5003).each do |port|
  Godhead::ThinRecipe.create(group_options.merge({
      :port        => port,
      :rackup_file => File.join(YUPFRONT_ROOT, 'yupfront/config.ru'),
      :runner_conf => File.join(YUPFRONT_ROOT, 'yupfront/production.yml') }))
end
