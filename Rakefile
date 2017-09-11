require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

gem_helper = Bundler::GemHelper.new

desc "Create tag #{gem_helper.send(:version_tag)}"
task :tag do
  gem_helper.send(:tag_version) unless gem_helper.send(:already_tagged?)
end
