require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "godhead"
    gem.summary = %Q{God recipes that separate configuration for processes, site policy and notifications; comes with many examples}
    gem.description = %Q{Configure God monitored processes according to their concerns the servers (path and so forth), site policy (number, ports, etc), and notification (email groups, mailserver, etc).}
    gem.email = "coders@infochimps.org"
    gem.homepage = "http://github.com/infochimps/godhead"
    gem.authors = ["Philip (flip) Kromer, Dhruv Bansal, Carl Knutson"]
    gem.add_development_dependency "yard", ">= 0"
    gem.add_development_dependency "rspec"
    gem.add_dependency 'god'
    gem.add_dependency 'activesupport'
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies
task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
