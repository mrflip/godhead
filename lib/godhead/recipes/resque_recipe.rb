# module Godhead
#   #
#   # Resque monitoring recipe
#   #
#   # inspired by http://railscasts.com/episodes/130-monitoring-with-god
#   class ResqueRecipe < GodRecipe
#     DEFAULT_OPTIONS = {
#       :max_cpu_usage   => 30.percent,
#       :max_mem_usage   => 100.megabytes,
#       #
#       :port            => 22122,
#       :runner_dir      => ENV['RAILS_ROOT'],
#       :runner_env      => ENV['RAILS_ENV'],
#       # uid => nil,
#       # gid => nil,
#     }
#     def self.default_options() super.deep_merge(DEFAULT_OPTIONS) ; end
# 
#     def start_command
#       "env QUEUE=critical,high,low /usr/bin/rake -f #{options[:runner_dir]}/Rakefile #{options[:runner_env]} resque:work"
#     end
#   end
# end


#     # restart if memory gets too high
#     w.transition(:up, :restart) do |on|
#       on.condition(:memory_usage) do |c|
#         c.above = 350.megabytes
#         c.times = 2
#       end
#     end
#  
#     # determine the state on startup
#     w.transition(:init, { true => :up, false => :start }) do |on|
#       on.condition(:process_running) do |c|
#         c.running = true
#       end
#     end
#  
#     # determine when process has finished starting
#     w.transition([:start, :restart], :up) do |on|
#       on.condition(:process_running) do |c|
#         c.running = true
#         c.interval = 5.seconds
#       end
#  
#       # failsafe
#       on.condition(:tries) do |c|
#         c.times = 5
#         c.transition = :start
#         c.interval = 5.seconds
#       end
#     end
#  
#     # start if process is not running
#     w.transition(:up, :start) do |on|
#       on.condition(:process_running) do |c|
#         c.running = false
#       end
#     end
#   end
# end
