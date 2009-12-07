module Godhead
  #
  # Workling monitoring recipe
  #
  # inspired by http://railscasts.com/episodes/130-monitoring-with-god
  class WorklingRecipe < GenericWorkerRecipe
    DEFAULT_OPTIONS = {
      :max_cpu_usage    => 80.percent,
      :max_mem_usage    => 100.megabytes,
      :start_grace_time => 20.seconds,
      #
      :runner_path      => nil,
    }
    def self.default_options() super.deep_merge(DEFAULT_OPTIONS) ; end

    def tell_runner action
      "#{options[:runner_path]} #{action}"
    end
    def start_command()   tell_runner 'start'   end
    def stop_command()    tell_runner 'stop'    end
    def restart_command() tell_runner 'restart' end
  end
end
