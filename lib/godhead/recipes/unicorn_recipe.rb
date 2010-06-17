module Godhead
  #
  # Unicorn monitoring recipe
  #
  # inspired by http://railscasts.com/episodes/130-monitoring-with-god
  class UnicornRecipe < GodRecipe
    DEFAULT_OPTIONS = {
      :max_cpu_usage    => 10.percent,
      :max_mem_usage    => 50.megabytes,
      :uid              => nil,               # probably want to set this
      #
      :root_dir         => nil,               # required to set this
      :runner_path      => 'unicorn',
      :runner_conf      => 'unicorn-conf.rb',
      :runner_env       => 'production',
    }
    def self.default_options() super.deep_merge(DEFAULT_OPTIONS) ; end

    def start_command
      [
        "cd #{options[:root_dir]} && #{options[:runner_path]}",
        "-c #{options[:runner_conf]}", # config file
        "-E #{options[:runner_env]}",  # environment
        "-D",                          # daemonize
        ].flatten.compact.join(" ")
    end

    def pid_file
      options[:pid_file] || options[:root_dir]+'/tmp/unicorn.pid'
    end

    # send QUIT signal: gracefully shuts down workers
    def stop_command
      "kill -QUIT `cat #{pid_file}`"
    end

    # # USR2 causes the master to re-create itself and spawn a new worker pool
    def restart_command
      old_pid = pid_file
      "kill -USR2 #{old_pid} ; sleep 4 ; kill -QUIT #{old_pid}"
    end
  end
end
