require "cpf_cnpj/version"

module CpfCnpj
	def self.type_of(cpf_cnpj)
		return nil if cpf_cnpj.nil?
		unless cpf_cnpj.is_a?(String)
			raise(ArgumentError, "argument must be a string or nil")
		end
		case cpf_cnpj.length
		when 11 ; :cpf
		when 14 ; :cnpj
		else ; nil
		end
	end
end
