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
tyrant_recipe.do_setup!     group_options.merge(:port => port + 0)
# Godhead::NginxRecipe.create group_options.merge({ })
Godhead::NginxRunnerRecipe.create group_options.merge({ })

  # w.lifecycle do |on|
  #   on.condition(:process_exits) do |c|
  #     c.notify = 'dhruv'
  #   end
  # end

