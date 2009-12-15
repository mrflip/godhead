module Godhead
  #
  # Tokyo Tyrant
  #
  # Lets god do the process management by killing/restarting according to the
  # pid file
  class TyrantRecipe < GodRecipe
    DEFAULT_OPTIONS = {
      :max_cpu_usage  => 50.percent,
      :max_mem_usage  => 150.megabytes,
      # runner-specific
      :listen_on      => '0.0.0.0',
      :port           => 1978,
      :db_dirname     => '/tmp',
      :runner_path     => '/usr/local/bin/ttserver',
    }
    def self.default_options()
      super.deep_merge(Godhead::TyrantRecipe::DEFAULT_OPTIONS)
    end

    def dbname
      basename = options[:db_name] || (handle+'.tct')
      File.join(options[:db_dirname], basename)
    end

    # create any directories required by the process
    def mkdirs!
      FileUtils.mkdir_p File.dirname(dbname)
      super
    end

    def start_command
      [
        options[:runner_path],
        "-host #{options[:listen_on]}",
        "-port #{options[:port]}",
        "-log  #{process_log_file}",
        dbname
      ].flatten.compact.join(" ")
    end

    # don't try to invent a pid_file -- by default god will find and make one
    # and will handle task killing/restarting/etc.
    def pid_file()
      nil
    end
  end
end

#
# -host   name        : specify the host name or the address of the server.  By default, every network address is bound.
# -port   num         : specify the port number.  By default, it is 1978.
#
# -thnum  num         : specify the number of worker threads.  By default, it is 8.
# -tout   num         : specify the timeout of each session in seconds.  By default, no timeout is specified.
#
# -log    path        : output log messages into the file.
# -ld                 : log debug messages also.
# -le                 : log error messages only.
# -ulog   path        : specify the update log directory.
# -ulim   num         : specify the limit size of each update log file.
# -uas                : use asynchronous I/O for the update log.
#
# -sid    num         : specify the server ID.
# -mhost  name        : specify the host name of the replication master server.
# -mport  num         : specify the port number of the replication master server.
# -rts    path        : specify the replication time stamp file.
# -rcc                : check consistency of replication.
#
# -skel   name        : specify the name of the skeleton database library.
# -ext    path        : specify the script language extension file.
# -extpc  name period : specify the function name and the calling period of a periodic command.
# -mask   expr        : specify the names of forbidden commands.
# -unmask expr        : specify the names of allowed commands.
#
