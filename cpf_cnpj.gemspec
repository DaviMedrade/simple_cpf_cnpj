# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cpf_cnpj/version'

Gem::Specification.new do |spec|
	spec.name          = "cpf_cnpj"
	spec.version       = CpfCnpj::VERSION
	spec.authors       = ["David Santos"]
	spec.email         = ["david@dsantosdev.com"]

	spec.summary       = %q{Provides a module with functions to detect, format, and validate CPFs and CNPJs.}
	spec.description   = %q{CpfCnpj is a module that provides functions to detect, validate, and format CPFs and CNPJs (Brazilian federal ID numbers).}
	spec.homepage      = "TODO: Put your gem's website or public repo URL here."

	spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
	spec.bindir        = "exe"
	spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
	spec.require_paths = ["lib"]

	spec.add_development_dependency "bundler", "~> 1.10"
	spec.add_development_dependency "rake", "~> 10.0"
	spec.add_development_dependency "minitest"
end
