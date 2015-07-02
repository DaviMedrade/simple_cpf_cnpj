require 'test_helper'

# Valid CPF and CNPJ generated by http://www.geradordecpf.org/
VALID_CPF = '11026822840'
VALID_CNPJ = '64338413000163'
# Invalid CPF and CNPJ are the valid ones with a digit changed
INVALID_CPF = '01026822840'
INVALID_CNPJ = '04338413000163'

class CpfCnpjTest < Minitest::Test
	def test_that_it_has_a_version_number
		refute_nil ::CpfCnpj::VERSION
	end

	def test_type_of_recognizes_cpf
		assert_equal(:cpf, CpfCnpj.type_of(VALID_CPF))
	end

	def test_type_of_accepts_invalid_cpf
		assert_equal(:cpf, CpfCnpj.type_of(INVALID_CPF))
	end

	def test_type_of_recognizes_cnpj
		assert_equal(:cnpj, CpfCnpj.type_of(VALID_CNPJ))
	end

	def test_type_of_accepts_invalid_cnpj
		assert_equal(:cnpj, CpfCnpj.type_of(INVALID_CNPJ))
	end

	def test_type_of_returns_nil_on_arbitrary_strings
		assert_nil(CpfCnpj.type_of('123456789'))
	end

	def test_type_of_returns_nil_on_nil
		assert_nil(CpfCnpj.type_of(nil))
	end

	def test_type_of_raises_on_non_nil_non_string
		assert_raises ArgumentError do
			CpfCnpj.type_of(VALID_CPF.to_i)
		end
	end
end
