# -*-ruby-*-

God.watch do |w|
  w.name          = "nginx"
  w.group         = "yuploader"
  
  w.start         = "service nginx start"
  w.start_grace   = 10.seconds

  w.stop          = "service nginx stop"

  w.restart       = "service nginx restart"
  w.restart_grace = 10.seconds
  
  w.pid_file      = "/var/run/nginx/nginx.pid"
  w.behavior(:clean_pid_file)

  w.lifecycle do |on|
    on.condition(:process_exits) do |c|
      c.notify = 'dhruv'
    end
  end
end
