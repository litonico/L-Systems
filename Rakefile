require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*.rb']
  t.verbose = true
end

task :examples do
  Dir["examples/*.rb"].each do |example|
    puts example
    system "rsdl -Ilib #{example}"
  end
end
