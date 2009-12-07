module Godhead
  #
  # Starling monitoring recipe
  #
  # inspired by http://railscasts.com/episodes/130-monitoring-with-god
  class StarlingRecipe < GodRecipe
    DEFAULT_OPTIONS = {
      :max_cpu_usage   => 30.percent,
      :max_mem_usage   => 20.megabytes,
      #
      :port            => 22122,
    }
    def self.default_options() super.deep_merge(DEFAULT_OPTIONS) ; end

    def start_command
      "starling  -d -p #{options[:port]} -d -P #{pid_file}"
    end

  end
end
