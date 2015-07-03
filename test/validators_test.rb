require 'test_helper'

class CpfCnpjTest::ValidatorsTest < CpfCnpjTest
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

		def test_returns_false_when_obviously_fake
			0.upto(9) do |d|
				refute(CpfCnpj.valid_cpf?(d.to_s * 11))
			end
		end
	end

	class ValidCnpjTest < CpfCnpjTest
		def test_returns_true_when_valid
			assert(CpfCnpj.valid_cnpj?(VALID_CNPJ))
		end

		def test_returns_false_when_invalid
			refute(CpfCnpj.valid_cnpj?(INVALID_CNPJ))
		end

		def test_returns_false_when_not_cnpj
			refute(CpfCnpj.valid_cnpj?(VALID_MOD11_CNPJ_TOO_SHORT))
			refute(CpfCnpj.valid_cnpj?(VALID_MOD11_CNPJ_TOO_LONG))
		end

		def test_returns_false_when_obviously_fake
			0.upto(9) do |d|
				refute(CpfCnpj.valid_cnpj?(d.to_s * 14))
			end
		end
	end

	class ValidCpfCnpjTest < CpfCnpjTest
		def test_returns_true_when_valid_cpf
			assert(CpfCnpj.valid_cpf_cnpj?(VALID_CPF))
		end

		def test_returns_true_when_valid_cnpj
			assert(CpfCnpj.valid_cpf_cnpj?(VALID_CNPJ))
		end

		def test_returns_false_when_invalid_cpf
			refute(CpfCnpj.valid_cpf_cnpj?(INVALID_CPF))
		end

		def test_returns_false_when_invalid_cnpj
			refute(CpfCnpj.valid_cpf_cnpj?(INVALID_CNPJ))
		end

		def test_returns_false_when_wrong_length
			refute(CpfCnpj.valid_cpf_cnpj?(VALID_MOD11_CPF_TOO_SHORT))
			refute(CpfCnpj.valid_cpf_cnpj?(VALID_MOD11_CPF_TOO_LONG))
			refute(CpfCnpj.valid_cpf_cnpj?(VALID_MOD11_CNPJ_TOO_SHORT))
			refute(CpfCnpj.valid_cpf_cnpj?(VALID_MOD11_CNPJ_TOO_LONG))
		end
	end
end
