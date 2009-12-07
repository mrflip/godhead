module Godhead
  #
  # Unicorn monitoring recipe
  #
  # inspired by http://railscasts.com/episodes/130-monitoring-with-god
  class UnicornRecipe < GodRecipe
    DEFAULT_OPTIONS = {
      :max_cpu_usage    => 50.percent,
      :max_mem_usage    => 300.megabytes,
      #
      :runner_path      => nil,
      :run_from_dir     => ENV['RAILS_ROOT'],
      :runner_conf      => ENV['RAILS_ROOT']+'/config/unicorn.rb',
      :runner_env       => 'production',
    }
    def self.default_options() super.deep_merge(DEFAULT_OPTIONS) ; end

    def start_command
      [
        "cd #{options[:run_from_dir]} && ",
        options[:runner_path],
        "-c #{options[:runner_conf]}", # config file
        "-E #{options[:runner_env]}",  # environment
        "-D",                          # daemonize
        ]
    end

    # send QUIT signal: gracefully shuts down workers
    def stop_command
      "kill -QUIT `cat #{pid_file}`"
    end

    # # USR2 causes the master to re-create itself and spawn a new worker pool
    def restart_command
      "kill -USR2 `cat #{pid_file}`"
    end
  end
end
