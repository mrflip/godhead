module Godhead
  #
  # Nginx monitoring recipe
  #
  class GenericNginxRecipe < GodRecipe
    DEFAULT_OPTIONS = {
      :max_cpu_usage   => 20.percent,
      :max_mem_usage   => 500.megabytes,
      :pid_file        => "/var/run/nginx/nginx.pid",
    }
    def self.default_options() super.deep_merge(DEFAULT_OPTIONS) ; end

    def self.recipe_name
      'nginx'
    end

    def mkdirs!
      FileUtils.mkdir_p File.dirname(options[:pid_file])
      super
    end
  end

  # Recipe for nginx process
  #
  # uses 'service nginx start' and so forth for task management
  class NginxRecipe < GenericNginxRecipe
    include Godhead::RunsAsService
  end

  # Recipe for nginx process, use on OSX
  #
  # calls out to the runner directly, as defined by :runner_path and
  #:runner_conf option
  class NginxRunnerRecipe < GenericNginxRecipe
    DEFAULT_OPTIONS = {
      # runner options
      :runner_path     => '/usr/local/nginx/sbin/nginx',
      :runner_conf     => nil,
    }
    def self.default_options() super.deep_merge(DEFAULT_OPTIONS) ; end

    # send signal to a master process: stop, quit, reopen, reload
    def tell_runner action=nil
      [
        options[:runner_path],
        (options[:runner_conf] ? "-c #{options[:runner_conf]}" : nil),
        (!action.blank?        ? "-s #{action}"                : nil),
      ].flatten.compact.join(" ")
    end

    def start_command()   tell_runner ''        ; end
    def stop_command()    tell_runner 'stop'    ; end
    def restart_command() tell_runner 'restart' ; end

  end
end

# nginx version: nginx/0.7.61
# Usage: nginx [-?hvVt] [-s signal] [-c filename] [-p prefix] [-g directives]
#
# Options:
#   -?,-h         : this help
#   -v            : show version and exit
#   -V            : show version and configure options then exit
#   -t            : test configuration and exit
#   -s signal     : send signal to a master process: stop, quit, reopen, reload
#   -p prefix     : set prefix path (default: /usr/local/nginx/)
#   -c filename   : set configuration file (default: /slice/etc/nginx/nginx.conf)
#   -g directives : set global directives out of configuration file
