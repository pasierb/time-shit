require 'rake'
require 'rake/testtask'
require 'bundler'

Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/time_shit/test*.rb']
end

task :default do
  Rake::Task["test"].invoke
end