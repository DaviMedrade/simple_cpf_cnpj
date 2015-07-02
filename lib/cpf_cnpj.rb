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

	def self.format(cpf_cnpj)
		case type_of(cpf_cnpj)
		when :cpf
			"#{cpf_cnpj[0..2]}.#{cpf_cnpj[3..5]}.#{cpf_cnpj[6..8]}-#{cpf_cnpj[9..10]}"
		when :cnpj
			"#{cpf_cnpj[0..1]}.#{cpf_cnpj[2..4]}.#{cpf_cnpj[5..7]}/#{cpf_cnpj[8..11]}-#{cpf_cnpj[12..13]}"
		else
			cpf_cnpj
		end
	end
end
