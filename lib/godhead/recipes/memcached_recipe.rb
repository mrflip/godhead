module Godhead
  #
  # Nginx monitoring recipe
  #
  class MemcachedRecipe < GodRecipe
    DEFAULT_OPTIONS = {
      :max_cpu_usage   => 20.percent,
      :max_mem_usage   => 500.megabytes,
      #
      :pid_file        => "/var/run/god/memcached.pid",
      :port            => 45000,
    }
    def self.default_options() super.deep_merge(DEFAULT_OPTIONS) ; end
    include Godhead::RunsAsService

    def start_command
      "memcached -p #{options[:port]} -d -P #{options[:pid_file]}"
    end

  end
end
