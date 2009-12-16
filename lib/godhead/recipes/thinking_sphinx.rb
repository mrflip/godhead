# From Jesse Newland http://jnewland.com at http://gist.github.com/188053
#

# God.watch do |w|
#   w.name = "delayed_delta"
#   w.group = "sphinx"
#   w.interval = 30.seconds
#   w.start = "rake -f #{RAILS_ROOT}/Rakefile thinking_sphinx:delayed_delta"
#   w.env = { "RAILS_ENV" => "production"}
#   w.uid = 'rails'
#   w.gid = 'rails'
#
#   # retart if memory gets too high
#   w.transition(:up, :restart) do |on|
#     on.condition(:memory_usage) do |c|
#       c.above = 300.megabytes
#       c.times = 2
#     end
#   end
#
#   # determine the state on startup
#   w.transition(:init, { true => :up, false => :start }) do |on|
#     on.condition(:process_running) do |c|
#       c.running = true
#     end
#   end
#
#   # determine when process has finished starting
#   w.transition([:start, :restart], :up) do |on|
#     on.condition(:process_running) do |c|
#       c.running = true
#       c.interval = 5.seconds
#     end
#
#     # failsafe
#     on.condition(:tries) do |c|
#       c.times = 5
#       c.transition = :start
#       c.interval = 5.seconds
#     end
#   end
#
#   # start if process is not running
#   w.transition(:up, :start) do |on|
#     on.condition(:process_running) do |c|
#       c.running = false
#     end
#   end
# end
# God.watch do |w|
#   w.name = "searchd"
#   w.group = "sphinx"
#   w.interval = 30.seconds
#   w.start = "searchd --config #{RAILS_ROOT}/config/#{RAILS_ENV}.sphinx.conf"
#   w.start_grace = 10.seconds
#   w.stop = "searchd --config #{RAILS_ROOT}/config/#{RAILS_ENV}.sphinx.conf --stop"
#   w.stop_grace = 10.seconds
#   w.pid_file = "#{RAILS_ROOT}/log/searchd.#{RAILS_ENV}.pid"
#   w.uid = 'rails'
#   w.gid = 'rails'
#
#   # retart if memory gets too high
#   w.transition(:up, :restart) do |on|
#     on.condition(:memory_usage) do |c|
#       c.above = 300.megabytes
#       c.times = 2
#     end
#   end
#
#   # determine the state on startup
#   w.transition(:init, { true => :up, false => :start }) do |on|
#     on.condition(:process_running) do |c|
#       c.running = true
#     end
#   end
#
#   # determine when process has finished starting
#   w.transition([:start, :restart], :up) do |on|
#     on.condition(:process_running) do |c|
#       c.running = true
#       c.interval = 5.seconds
#     end
#
#     # failsafe
#     on.condition(:tries) do |c|
#       c.times = 5
#       c.transition = :start
#       c.interval = 5.seconds
#     end
#   end
#
#   # start if process is not running
#   w.transition(:up, :start) do |on|
#     on.condition(:process_running) do |c|
#       c.running = false
#     end
#   end
# end
