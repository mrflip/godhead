module Godhead
  class ThinRecipe < GodRecipe
    DEFAULT_OPTIONS = {
      :default_interval => 30.seconds,
      :port             => 3000,
      :thin_port_offset => 3000,
      :runner_path      => '/usr/bin/thin',        # path to thin. Override this in the site config file.
      :runner_conf      => nil,
      :pid_file         => nil,
    }
    def self.default_options() super.deep_merge(DEFAULT_OPTIONS) ; end

    # Call the thin runner script
    def tell_runner action
      [
        options[:runner_path],
        "--config=#{options[:runner_conf]}",
        "--rackup=#{options[:rackup_file]}",
        "--port=#{  options[:port]}",
        "--pid=#{pid_file}",
        # "--only=#{options[:port].to_i - options[:thin_port_offset].to_i}",
        action
      ].flatten.compact.join(" ")
    end
    def start_command()   tell_runner :start   end
    def restart_command() tell_runner :restart end
    def stop_command()    tell_runner :stop    end
  end
end
