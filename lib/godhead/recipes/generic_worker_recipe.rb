# -*-ruby-*-

YUPSHOT_DIR           = "/slice/www/apps/yuploader_static/yupshot"
YUPSHOT_WORKER_DAEMON = File.join(YUPSHOT_DIR, "bin/yupshot_worker_daemon")
YUPSHOT_PID_DIR       = File.join(YUPSHOT_DIR, "tmp/pids")

God.watch do |w|
  w.name        = "memcached"
  w.group       = "yupshot"
  w.group       = "yuploader"
  pid_file      = File.join(YUPSHOT_PID_DIR, "memcached")

  w.start       = "memcached -p 45000 -d -P #{pid_file}"
  w.start_grace = 10.seconds

  w.stop        = "killall memcached"

  w.pid_file    = pid_file
  w.behavior(:clean_pid_file)

  w.lifecycle do |on|
    on.condition(:process_exits) do |c|
      c.notify = 'dhruv'
    end
  end
end

God.watch do |w|
  w.name  = "starling"
  w.group = "yupshot"
  w.group = "yuploader"
  pid_file = File.join(YUPSHOT_PID_DIR, "starling")

  w.start       = "starling -d -P #{pid_file}"
  w.start_grace = 10.seconds

  w.stop = "killall starling"

  w.pid_file = pid_file
  w.behavior(:clean_pid_file)

  w.lifecycle do |on|
    on.condition(:process_exits) do |c|
      c.notify = 'dhruv'
    end
  end
end

God.watch do |w|
  w.name  = "worker_daemon"
  w.group = "yupshot"
  w.group = "yuploader"

  w.start = "sudo -u www-data #{YUPSHOT_WORKER_DAEMON}"
  w.start_grace = 10.seconds

  w.stop = "killall yupshot_worker_daemon"

  w.lifecycle do |on|
    on.condition(:process_exits) do |c|
      c.notify = 'dhruv'
    end
  end
end
