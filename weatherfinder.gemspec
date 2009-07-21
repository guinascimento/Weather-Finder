Gem::Specification.new do |s|
  s.name = %q{weatherfinder}
  s.version = "1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Guilherme Nascimento"]
  s.date = %q{2009-02-20}
  s.description = %q{Weather Finder is a Ruby library to access Weather.com data (XOAP)}
  s.email = ["javaplayer@gmail.com"]
  s.files = ["weatherfinder.gemspec","lib/weatherfinder.rb", "lib/current.rb", "lib/day.rb", "lib/forecast.rb", "lib/future_estimate.rb", "lib/night.rb", "lib/wind.rb"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{weatherfinder}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Weather Finder is a Ruby library to access Weather.com data (XOAP). The library uses Hpricot and MemCached and allows fetch current forecast data from anywhere location.}
  s.homepage = %q{http://weatherfinder.rubyforge.org/}
  s.has_rdoc = true
end