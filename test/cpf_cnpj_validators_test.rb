require 'test_helper'

class CpfCnpjValidatorsTest < CpfCnpjTest
	class ValidCpfTest < CpfCnpjTest
		def test_returns_true_when_valid
			assert(CpfCnpj.valid_cpf?(VALID_CPF))
		end

		def test_returns_false_when_invalid
			refute(CpfCnpj.valid_cpf?(INVALID_CPF))
		end

		def test_returns_false_when_not_cpf
			refute(CpfCnpj.valid_cpf?(VALID_MOD11_CPF_TOO_SHORT))
			refute(CpfCnpj.valid_cpf?(VALID_MOD11_CPF_TOO_LONG))
		end
	end
end
