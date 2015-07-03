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

		# If the string is not a number, String#to_i returns zero. So, if the digits
		# are converted using #to_i, the check succeeds if the string has a non-numeric character
		# in a place where a zero would make the check succeed.
		def test_returns_false_when_non_digits
			# if any character is zero
			refute(CpfCnpj._mod11_check_digit(VALID_CPF_WITH_ZERO.sub('0', 'a'), MAX_MULTI_CPF))
			# the last character is not used to calculate, just to verify, so it could be vulnerable
			# even if the others are checked for range
			refute(CpfCnpj._mod11_check_digit(VALID_CPF_END_ZERO.sub(/0\z/, 'a'), MAX_MULTI_CPF))
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

	class OrdTest < CpfCnpjTest
		def test_returns_the_ascii_code
			assert_equal(65, CpfCnpj._ord("A"))
			assert_equal(48, CpfCnpj._ord("0"))
		end
	end
end
