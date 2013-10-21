require 'yaml'
class EnvironmentYml

  attr_reader :yml

  def initialize environment
    @yml = ::YAML::load(File.open(environment + '-environment.yaml'))
  end

  def ssh_port
    @ssh_port ||= global['ssh_port']
  end

  def hash_of_roles
    @hash_of_roles = @yml['hosts']
  end
  def hosts
    @hosts ||= @yml['hosts'].each.collect { |type, hash| Host.new(type, hash['ip'], hash['manifest'], global) }
  end

  def all
    if @yml['hosts'].include?('all')
      true
    else
      false
    end
  end
  private
  def global
    @yml['global']
  end

end