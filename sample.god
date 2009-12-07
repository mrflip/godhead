#!/usr/bin/env ruby
require 'rubygems'
require 'god'
require 'active_support'

$: << File.dirname(__FILE__)+'/lib'
require 'godhead'
# God.load "/slice/etc/god/*.god"


tyrant_recipe = Godhead::TyrantRecipe.new

group_options = { :monitor_group => :yuploader, }
port  = 11220
# tyrant_recipe.do_setup!     group_options.merge(:port => port + 0)

# Godhead::NginxRecipe.create group_options.merge({ })
# Godhead::NginxRunnerRecipe.create group_options.merge({ })
# Godhead::GenericWorkerRecipe.create :runner_path => "/slice/www/apps/yuploader_static/yupshot/bin/yupshot_worker_daemon"
# Godhead::StarlingRecipe.create
# Godhead::MemcachedRecipe.create


YUPFRONT_ROOT = "/slice/www/apps/yupfront"
(5000..5002).each do |port|
  Godhead::ThinRecipe.create({
      :port        => port,
      :rackup      => File.join(YUPFRONT_ROOT, 'config.ru'),
      :runner_conf => File.join(YUPFRONT_ROOT, 'production.yml') })
end
