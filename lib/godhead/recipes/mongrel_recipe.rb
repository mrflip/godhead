module Godhead
  class ThinRecipe < GodRecipe
    DEFAULT_OPTIONS = {
      :default_interval => 30.seconds,
      :max_cpu_usage    => 50.percent,
      :max_mem_usage    => 150.megabytes,
      :port             => 5000,
      :runner_path      => 'mongrel_rails', # path to mongrel_rails. Override this in the site config file.
      :runner_conf      => nil,
      :pid_file         => nil,
    }
    def self.default_options() super.deep_merge(DEFAULT_OPTIONS) ; end

    # Call the thin runner script
    def tell_runner action
      [
        options[:runner_path],
        "--config=#{options[:runner_conf]}",
        "--port=#{  options[:port]}",
        (action == 'stop' ? nil : '-d'),
        (action == 'stop' ? nil : "--pid=#{pid_file}"),
        action
      ].flatten.compact.join(" ")
    end
    def start_command()   tell_runner :start   end
    def restart_command() tell_runner :restart end
    def stop_command()    tell_runner :stop    end
  end
end
