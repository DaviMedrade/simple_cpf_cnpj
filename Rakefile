require "bundler/gem_tasks"
require "rake/testtask"
require "rdoc/task"

Rake::TestTask.new(:test) do |t|
	t.libs << "test"
	t.libs << "lib"
	t.test_files = FileList['test/**/*_test.rb']
end

RDoc::Task.new(:doc) do |rd|
	rd.main = "README.md"
	rd.rdoc_files.include("README.md", "LICENSE", "lib/**/*.rb")
	rd.rdoc_dir = "doc/v#{CpfCnpj::VERSION}"
end

desc "Prepare the documentation for publishing"
task 'doc:prepare' => [:doc] do |t|
	File.write("doc/index.html", <<-EOT)
		<html>
			<head>
				<meta http-equiv='content-type' content='text/html; charset=utf-8' />
				<meta http-equiv='refresh' content='0; ./v#{CpfCnpj::VERSION}/index.html' />
				<title>Redirecting&hellip;</title>
			</head>
			<body>Redirecting&hellip;</body>
		</html>
	EOT
end

task :default => :test
