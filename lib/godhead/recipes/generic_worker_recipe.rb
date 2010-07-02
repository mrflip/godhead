module Godhead
  #
  # Generic worker process monitoring recipe
  #
  class GenericWorkerRecipe < GodRecipe
    DEFAULT_OPTIONS = {
      :max_cpu_usage   => 20.percent,
      :max_mem_usage   => 50.megabytes,
      #
      :runner_path     => nil
    }
    def self.default_options() super.deep_merge(DEFAULT_OPTIONS) ; end

    def initialize _options={}
      super _options
      p [options, handle, process_log_file]
      raise "need a runner path" unless options[:runner_path]
    end

    # name the recipe after the worker script
    def recipe_name
      File.basename(options[:runner_path]).gsub(/\..*/, '')
    end

    # don't try to invent a pid_file -- by default god will find and make one
    # and will handle task killing/restarting/etc.
    def pid_file()
      nil
    end

    def setup_watcher watcher
      super
      watcher.log = process_log_file
    end

    def start_command
      options[:runner_path]
    end
    
  end
end
