module Godhead
  class BeanstalkdRecipe < GodRecipe
    DEFAULT_OPTIONS = {
      :listen_on       => '0.0.0.0',
      :port            => 11300,
      :max_job_size    => '65535',
      :max_cpu_usage   => 20.percent,
      :max_mem_usage   => 500.megabytes,
      :runner_path => '/usr/local/bin/beanstalkd',
    }
    def self.default_options() super.deep_merge(Godhead::BeanstalkdRecipe::DEFAULT_OPTIONS) ; end

    def start_command
      [
        options[:runner_path],
        "-l #{options[:listen_on]}",
        "-p #{options[:port]}",
        (options[:user] ? "-u #{options[:user]}" : nil),
        "-z #{options[:max_job_size]}",
      ].flatten.compact.join(" ")
    end
  end
end

# $ beanstalkd -h
# Use: beanstalkd [OPTIONS]
#
# Options:
#  -d       detach
#  -l ADDR  listen on address (default is 0.0.0.0)
#  -p PORT  listen on port (default is 11300)
#  -u USER  become user and group
#  -z SIZE  set the maximum job size in bytes (default is 65535)
#  -v       show version information
#  -h       show this help
#
