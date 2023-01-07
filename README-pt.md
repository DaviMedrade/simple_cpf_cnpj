# simple_cpf_cnpj

[![Gem Version](https://badge.fury.io/rb/simple_cpf_cnpj.svg)](https://rubygems.org/gems/simple_cpf_cnpj)
![Tests](https://github.com/DaviMedrade/simple_cpf_cnpj/actions/workflows/run-tests.yml/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/365c37a70f61436932a4/maintainability)](https://codeclimate.com/github/DaviMedrade/simple_cpf_cnpj/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/365c37a70f61436932a4/test_coverage)](https://codeclimate.com/github/DaviMedrade/simple_cpf_cnpj/test_coverage)

**English Version:** [README.md](rdoc-ref:README.md)

A gem `simple_cpf_cnpj` fornece o módulo CpfCnpj, que possui métodos utilitários para lidar com CPFs e CNPJs.

Um CPF é um número de identificação federal brasileiro emitido para pessoas físicas, e um CNPJ é o equivalente para pessoas jurídicas (empresas e afins).

O módulo fornece métodos para diferenciar um CPF de um CNPJ, formatar, e validar os números por meio da confirmação dos dígitos verificadores.

## Compatibilidade

O código é testado com o Ruby (1.8.7, 1.9.2, 1.9.3, 2.0.0, 2.1, and 2.2), JRuby, e Ruby Enterprise Edition 1.8.7.

## Instalação

Adicione esta linha ao Gemfile da sua aplicação:

```ruby
gem 'simple_cpf_cnpj'
```

Em seguida, execute:

```
$ bundle
```

Ou faça a instalação manualmente:

```
$ gem install simple_cpf_cnpj
```

## Utilização

A documentação completa pode ser encontrada em: http://docs.dsantosdev.com/simple_cpf_cnpj/

Se for necessário para a sua instalação, adicione isto ao seu código, no local adequado:

```ruby
require 'simple_cpf_cnpj'
```

### Representação de CPF/CNPJ

Os métodos neste módulo esperam que CPFs/CNPJs sejam passados como strings contendo somente caracteres numéricos. Se a string que você tem estiver formatada, é responsabilidade sua remover a pontuação antes de chamar métodos de CpfCnpj.

Isso pode ser feito dessa forma, por exemplo:

```ruby
CpfCnpj.valid_cpf?(formatted_cpf.gsub(/\D/, ''))
```

### Validando CPFs e CNPJs
Use CpfCnpj.valid_cpf?, CpfCnpj.valid_cnpj?, ou CpfCnpj.valid_cpf_cnpj? para verificar se um número é válido.

```ruby
CpfCnpj.valid_cpf?("12345678900") # inválido
# => false
CpfCnpj.valid_cpf?("11026822840") # válido
# => true
CpfCnpj.valid_cnpj?("12345678000100") # inválido
# => false
CpfCnpj.valid_cnpj?("63871464000193") # válido
# => true
CpfCnpj.valid_cpf_cnpj?("11026822840") # CPF válido
# => true
CpfCnpj.valid_cpf_cnpj?("63871464000193") # CNPJ válido
# => true
```

### Formatando CPFs e CNPJs
Use CpfCnpj.format para obter uma representação formatada de um CPF ou CNPJ.

```ruby
CpfCnpj.format("12345678987") # 11 dígitos (CPF)
# => "123.456.789-87"
CpfCnpj.format("01234567000198") # 14 dígitos (CNPJ)
# => "01.234.567/0001-98"
```

### Distinguindo CPFs de CNPJs
Use CpfCnpj.type_of para determinar se um número é um CPF ou um CNPJ. Note que esta verificação se baseia apenas no comprimento da string. Os caracteres que compõem a string nem chegam a ser acessados.

```ruby
CpfCnpj.type_of("12345678987") # 11 dígitos
# => :cpf
CpfCnpj.type_of("123456789876") # 12 dígitos
# => nil
CpfCnpj.type_of("01234567000198") # 14 dígitos
# => :cnpj
```

## Desenvolvimento

**Aviso:** isto não é necessário para poder utilizar a gem, apenas para fazer alterações ou executar os testes inclusos.

Após fazer checkout do repositório, execute `bin/setup` para instalar as dependências. Depois, execute `rake test` para rodar os testes. Você também pode executar `bin/console` para acessar uma prompt interativa onde você pode experimentar.

## Contribuindo

Relatórios de bugs e pull requests são bem-vindos. Envie pelo GitHub:
https://github.com/DaviMedrade/simple_cpf_cnpj/issues

## Licença e copyright

Copyright © 2015-2023 Davi Medrade

Este software é publicado sob a licença MIT, que pode ser encontrada no arquivo [LICENSE](rdoc-ref:LICENSE-pt).
