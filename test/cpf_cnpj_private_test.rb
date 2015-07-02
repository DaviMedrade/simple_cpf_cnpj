require 'test_helper'

class CpfCnpjPrivateTest < CpfCnpjTest
	# Correct maximum multipliers to be used with the mod11 algorithm
	MAX_MULTI_CPF = 11

	class Mod11CheckDigitTest < CpfCnpjTest
		def test_returns_true_when_correct
			assert(CpfCnpj._mod11_check_digit(VALID_CPF[0..-2], MAX_MULTI_CPF))
		end
		def test_returns_false_when_incorrect
			refute(CpfCnpj._mod11_check_digit(INVALID_CPF[0..-2], MAX_MULTI_CPF))
		end
	end
end
