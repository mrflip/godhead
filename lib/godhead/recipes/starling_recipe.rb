module Godhead
  #
  # Starling monitoring recipe
  #
  class StarlingRecipe < GodRecipe
    DEFAULT_OPTIONS = {
      :max_cpu_usage   => 20.percent,
      :max_mem_usage   => 50.megabytes,
      #
      :pid_file        => "/var/run/god/starling.pid",
      :port            => 45000,
    }
    def self.default_options() super.deep_merge(DEFAULT_OPTIONS) ; end

    def start_command
      "starling  -d -p #{options[:port]} -d -P #{options[:pid_file]}"
    end

  end
end
