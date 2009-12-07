module Godhead
  class ThinRecipe < GodRecipe
    DEFAULT_OPTIONS = {
      :port            => 3000,
      :runner_path     => '/usr/bin/thin',        # path to thin. Override this in the site config file.
      :runner_conf     => nil,
      :pid_file        => nil,
    }
    def self.default_options() super.deep_merge(DEFAULT_OPTIONS) ; end

    #     w.start         = "thin -s 3 -C #{YUPFRONT_CONFIG}  start"
    def tell_thin action
      [
        options[:runner_path],
        "--config=#{options[:runner_conf]}",
        "--rackup=#{options[:rackup_file]}",
        "--port=#{  options[:port]}",
        "--pid=#{pid_file}",
        action
      ].flatten.compact.join(" ")
    end

    def start_command
      tell_thin :start
    end

    def restart_command
      tell_thin :restart
    end

    def stop_command
      tell_thin :stop
    end
  end

end
