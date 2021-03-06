# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{statistics}
  s.version = "1.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alexandru Catighera"]
  s.date = %q{2010-09-10}
  s.email = %q{acatighera@gmail.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    ".gitignore",
     "CHANGES.markdown",
     "MIT-LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "init.rb",
     "lib/statistics.rb",
     "statistics.gemspec",
     "test/statistics_test.rb"
  ]
  s.homepage = %q{http://github.com/acatighera/statistics}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{An ActiveRecord gem that makes it easier to do reporting.}
  s.test_files = [
    "test/statistics_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

