#!/usr/bin/env ruby
require 'rubygems'
require 'god'
require 'active_support'
$: << File.dirname(__FILE__)+'/lib'
require 'godhead'

YUPFRONT_ROOT = "/slice/www/apps/yuploader_static/yupfront"

# ===========================================================================
#
# Yupshot god monitoring: the backend processing chain for yuploader
#
group_options = { :monitor_group => :yupshot, }
Godhead::MemcachedRecipe.create     group_options.merge({ :user => 'www-data', :pid_file => '/tmp/mc.pid'})
Godhead::StarlingRecipe.create      group_options
Godhead::GenericWorkerRecipe.create group_options.merge({
    :runner_path => "/slice/www/apps/yuploader_static/yupshot/bin/yupshot_worker_daemon" })

# ===========================================================================
#
# Yupfront god monitoring: the frontend processes for yuploader
#
group_options = { :monitor_group => :yupfront}
(5000..5000).each do |port|
  Godhead::ThinRecipe.create(group_options.merge({
      :port        => port,
      :rackup_file => File.join(YUPFRONT_ROOT, 'config.ru'),
      :runner_conf => File.join(YUPFRONT_ROOT, 'production.yml') }))
end
Godhead::NginxRecipe.create group_options.merge({ })
# replace with this one on OSX
# Godhead::NginxRunnerRecipe.create group_options.merge({ })
