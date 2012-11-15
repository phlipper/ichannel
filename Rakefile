require "bundler/gem_tasks"
desc 'Run the test suite.'
task :test do
  $LOAD_PATH.unshift 'lib'
  Dir["test/*_test.rb"].each do |file|
    require_relative file
  end
end
task :default => :test
