require 'test_helper'

class CpfCnpjPrivateTest < CpfCnpjTest
	# Correct maximum multipliers to be used with the mod11 algorithm
	MAX_MULTI_CPF = 11
	MAX_MULTI_CNPJ = 9

	class Mod11CheckDigitTest < CpfCnpjTest
		def test_returns_true_when_correct
			assert(CpfCnpj._mod11_check_digit(VALID_CPF[0..-2], MAX_MULTI_CPF))
		end
		def test_returns_false_when_incorrect
			refute(CpfCnpj._mod11_check_digit(INVALID_CPF[0..-2], MAX_MULTI_CPF))
		end
	end

	class Mod11CheckTest < CpfCnpjTest
		def test_returns_true_when_correct
			assert(CpfCnpj._mod11_check(VALID_CPF, MAX_MULTI_CPF))
			assert(CpfCnpj._mod11_check(VALID_CNPJ, MAX_MULTI_CNPJ))
		end
		def test_returns_false_when_incorrect
			refute(CpfCnpj._mod11_check(INVALID_CPF, MAX_MULTI_CPF))
			refute(CpfCnpj._mod11_check(INVALID_CNPJ, MAX_MULTI_CNPJ))
		end
	end
end
