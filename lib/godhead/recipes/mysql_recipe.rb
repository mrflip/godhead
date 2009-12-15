module Godhead
  #
  # Mysql monitoring recipe
  #
  # Pretty standard, but speed up the flapping window -- starts and restarts
  # should be fast, and we don't want the server down for long.
  class MysqlRecipe < GodRecipe
    DEFAULT_OPTIONS = {
      :flapping_window   => 2.minutes,
      :flapping_retry_in => 30.minutes,      
      :max_cpu_usage     => nil,
      :max_mem_usage     => nil,
      :pid_file          => "/var/run/mysqld/mysqld.pid",
      :port              => 80,
    }
    def self.default_options() super.deep_merge(DEFAULT_OPTIONS) ; end
    # uses 'service mysql start' and so forth for task management
    include Godhead::RunsAsService
  end
end
