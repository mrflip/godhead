module Godhead
  #
  # Starling monitoring recipe
  #
  class GenericWorkerRecipe < GodRecipe
    DEFAULT_OPTIONS = {
      :max_cpu_usage   => 20.percent,
      :max_mem_usage   => 50.megabytes,
      #
      :pid_dir         => "/var/run/god",
      :port            => 45000,
      :runner_path     => nil,
    }
    def self.default_options() super.deep_merge(DEFAULT_OPTIONS) ; end

    def initialize _options={}
      super _options
      raise "need a runner path" unless options[:runner_path]
      p options
    end

    # name the recipe after the worker script
    def recipe_name
      File.basename(options[:runner_path]).gsub(/\..*/, '')
    end

    def pid_file
      File.join(options[:pid_dir], recipe_name+'.pid')
    end

    def start_command
      [
        "sudo",
        (options[:user] ? "-u #{options[:user]}" : nil),
        options[:runner_path]
      ].flatten.compact.join(" ")
    end

  end
end
