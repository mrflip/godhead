module Godhead
  # Uses the init.d "service" command for running
  module RunsAsService
    # "service #{recipe_name} start"
    def start_command
      "service #{recipe_name} start"
    end

    # "service #{recipe_name} stop"
    def stop_command
      "service #{recipe_name} stop"
    end

    # "service #{recipe_name} restart"
    def restart_command
      "service #{recipe_name} restart"
    end
  end
end
