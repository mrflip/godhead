module Godhead
  #
  # Nginx monitoring recipe
  #
  # This defines standard options for nginx, and leaves it to subclasses to
  # define the start_command and conf path and so forth.
  #
  # The nginx monitor not only watches the PID but also checks for a correct
  # http_response_code
  class GenericNginxRecipe < GodRecipe
    DEFAULT_OPTIONS = {
      :max_cpu_usage   => nil,
      :max_mem_usage   => nil,
      :pid_file        => "/var/run/nginx/nginx.pid",
      :port            => 80,
    }
    def self.default_options() super.deep_merge(DEFAULT_OPTIONS) ; end

    # restart if can't contact server
    def setup_restart watcher
      super watcher
      watcher.restart_if do |restart|
        restart.condition(:http_response_code) do |c|
          c.host        = 'localhost'
          c.port        = options[:port]
          c.path        = '/'
          c.timeout     = 3.seconds
          c.times       = [4, 5] # 4 out of 5 times failure
          c.code_is_not = 200
        end
      end
    end

    def self.recipe_name
      'nginx'
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

