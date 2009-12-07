
# FIXME -- turn this into a godhead recipe

# ===========================================================================
#
# From http://github.com/blog/229-dj-god
#

# rails_root = "/data/github/current"
# 20.times do |num|
#   God.watch do |w|
#     w.name = "dj-#{num}"
#     w.group = 'dj'
#     w.interval = 30.seconds
#     w.start = "rake -f #{rails_root}/Rakefile production jobs:work"
#
#     w.uid = 'git'
#     w.gid = 'git'
#
#     # retart if memory gets too high
#     w.transition(:up, :restart) do |on|
#       on.condition(:memory_usage) do |c|
#         c.above = 300.megabytes
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

# ===========================================================================
#
# from http://livollmers.net/index.php/2008/11/05/asynchronous-mail-with-delayedjob-god-daemons/
#

# God.watch do |w|
#      w.name = "delayed_job_worker"
#      w.interval = 10.seconds
#      w.start = "#{RAILS_ROOT}/script/delayed_job_worker_control start -- production"
#      w.stop = "#{RAILS_ROOT}/script/delayed_job_worker_control stop"
#      w.restart = "#{RAILS_ROOT}/script/delayed_job_worker_control restart"
#      w.start_grace = 10.seconds
#      w.restart_grace = 10.seconds
#      w.pid_file = "#{RAILS_ROOT}/tmp/pids/delayed_job_worker.pid"
#
#      w.uid = "deploy"
#      w.gid = "root"
#      w.behavior(:clean_pid_file)
#      # determine the state on startup
#      w.transition(:init, { true => :up, false => :start }) do |on|
#        on.condition(:process_running) do |c|
#          c.running = true
#        end
#      end
#
#      # determine when process has finished starting
#      w.transition([:start, :restart], :up) do |on|
#        on.condition(:process_running) do |c|
#          c.running = true
#        end
#
#        # failsafe
#        on.condition(:tries) do |c|
#          c.times = 5
#          c.transition = :start
#        end
#      end
#
#      # start if process is not running
#      w.transition(:up, :start) do |on|
#        on.condition(:process_exits)
#      end
#
#      w.restart_if do |restart|
#        restart.condition(:memory_usage) do |c|
#          c.above = 100.megabytes
#          c.times = [3, 5]
#        end
#
#        restart.condition(:cpu_usage) do |c|
#          c.above = 50.percent
#          c.times = 5
#        end
#      end
#
#      w.lifecycle do |on|
#        on.condition(:flapping) do |c|
#          c.to_state = [:start, :restart]
#          c.times = 5
#          c.within = 5.minute
#          c.transition = :unmonitored
#          c.retry_in = 10.minutes
#          c.retry_times = 5
#          c.retry_within = 2.hours
#        end
#      end
#    end
# end
