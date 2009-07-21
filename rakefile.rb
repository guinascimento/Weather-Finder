require "rake/rdoctask"
require "rake/testtask"
require "rcov/rcovtask"

task :default => [:test_unit, :coverage, :rdoc]

Rake::TestTask.new(:test_unit) do |t|
	t.libs << "test"
    t.test_files = FileList['test/*.rb']
end

Rake::RDocTask.new(:rdoc) do |t|
	t.main = "README"
    t.rdoc_files.include("README", "lib/**/*.rb")
end

Rcov::RcovTask.new(:coverage) do |t|
	t.libs << "test"
    t.test_files = FileList['test/*.rb']
end
