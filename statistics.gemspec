# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{statistics}
  s.version = "1.0.3"

  s.authors = ["Alexandru Catighera"]
  s.date = %q{2010-09-10}
  s.email = %q{acatighera@gmail.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files`.split("\n").map { |f| f =~ /^bin\/(.*)/ ? $1 : nil }.compact
  s.require_path = 'lib'

  s.homepage = %q{http://github.com/acatighera/statistics}
  s.rdoc_options = ["--charset=UTF-8"]
  s.summary = %q{An ActiveRecord gem that makes it easier to do reporting.}

  # Dependencies
  s.required_rubygems_version = '>= 1.3.6'

  s.add_dependency 'activerecord', '~> 3.2'

  s.add_development_dependency 'bundler', '>= 1.0.0'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'mocha'
end

