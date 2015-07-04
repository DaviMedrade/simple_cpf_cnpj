# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_cpf_cnpj/version'

Gem::Specification.new do |spec|
	spec.name          = "simple_cpf_cnpj"
	spec.version       = CpfCnpj::VERSION
	spec.authors       = ["David Santos"]
	spec.email         = ["david@dsantosdev.com"]

	spec.summary       = %q{Provides the module CpfCnpj, with methods that detect, format, and validate CPFs and CNPJs.}
	spec.description   = <<EOT
Provides the module CpfCnpj, with methods that detect, validate, and format CPFs and CNPJs (Brazilian federal ID numbers).
//
Fornece o módulo CpfCnpj, com funções que detectam, validam, e formatam CPFs e CNPJs.
EOT
	spec.homepage      = "https://github.com/davidsantos-br/simple_cpf_cnpj"
	spec.license       = "MIT"

	spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
	spec.bindir        = "exe"
	spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
	spec.require_paths = ["lib"]
	spec.required_ruby_version = '>= 1.8.7'
	spec.extra_rdoc_files = ['README.md', 'LICENSE']
	spec.rdoc_options  << '--title' << 'simple_cpf_cnpj -- CPF/CNPJ utility methods' << '--main' << 'README.md'

	spec.add_development_dependency "bundler", "~> 1.10"
	spec.add_development_dependency "rake", "~> 10.0"
	spec.add_development_dependency "minitest"
	spec.add_development_dependency "rdoc"
end
