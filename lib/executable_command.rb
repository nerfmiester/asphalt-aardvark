require 'tempfile'

class ExecutableCommand

  def initialize cmd
     @cmd = cmd
  end

  def execute
    file = Tempfile.new("cmd")
    file.write("\n")
    t=Time.new
    file.write(t.strftime("Time Started : %T,%L"))
    file.write("\n")
    file.write('* ' * 10)
    file.write("Starting Command : #{@cmd}")
    file.write('* ' * 10)
    `#{@cmd} >> #{file.path} 2>&1`
    file.write("\n")
       if $?.exitstatus>0
          file.write('* ' * 10)
          file.write("Failed cmd - #{@cmd}")
          file.write('* ' * 10)
          file.write("\n")
          file.rewind
          system("cat #{file.path}")
          abort " "
        end

    file.write('* ' * 10)
    file.write("Completed cmd - #{@cmd}")
    file.write("\n")
    t=Time.new
    file.write(t.strftime("Time Completed : %T,%L"))
    file.write("\n")
    file.write('* ' * 10)
    file.write("\n")
    file.rewind
    system("cat #{file.path}")
    end
end