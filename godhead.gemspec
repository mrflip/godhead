# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{godhead}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Philip (flip) Kromer"]
  s.date = %q{2009-12-07}
  s.description = %q{Configure God monitored processes according to their concerns the servers (path and so forth), site policy (number, ports, etc), and notification (email groups, mailserver, etc).}
  s.email = %q{flip@infochimps.org}
  s.extra_rdoc_files = [
    "LICENSE",
     "README-god.textile"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README-god.textile",
     "Rakefile",
     "VERSION",
     "lib/godhead.rb",
     "lib/godhead/extensions.rb",
     "lib/godhead/extensions/hash.rb",
     "lib/godhead/god_recipe.rb",
     "lib/godhead/mixins.rb",
     "lib/godhead/mixins/runs_as_service.rb",
     "lib/godhead/notification.rb",
     "lib/godhead/notification/gmail.rb",
     "lib/godhead/process_groups.rb",
     "lib/godhead/recipes.rb",
     "lib/godhead/recipes/beanstalkd_recipe.rb",
     "lib/godhead/recipes/generic_worker_recipe.rb",
     "lib/godhead/recipes/memcached_recipe.rb",
     "lib/godhead/recipes/nginx_recipe.rb",
     "lib/godhead/recipes/starling_recipe.rb",
     "lib/godhead/recipes/thin_recipe.rb",
     "lib/godhead/recipes/tyrant_recipe.rb",
     "sample.god",
     "spec/godhead_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/mrflip/godhead}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{God recipes that separate configuration for processes, site policy and notifications; comes with many examples}
  s.test_files = [
    "spec/godhead_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_runtime_dependency(%q<extlib>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<extlib>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<extlib>, [">= 0"])
  end
end
