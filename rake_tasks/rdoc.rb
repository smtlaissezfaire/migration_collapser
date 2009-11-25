require 'rake'
require 'hanna/rdoctask'

DOC_DIRECTORY = File.dirname(__FILE__) + "/../doc"

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = DOC_DIRECTORY
  rdoc.title    = 'migration_collapser'
  rdoc.options << '--line-numbers' << '--inline-source'

  rdoc.options << '--webcvs=http://github.com/smtlaissezfaire/migration_collapser'

  ["README.rdoc", "GPL_LICENSE", "MIT_LICENSE", "lib/**/*.rb"].each do |file|
    rdoc.rdoc_files.include(file)
  end
end
