require_relative 'livro'
require_relative 'revista'
require_relative 'ebook'
require_relative 'contador'

class Estoque
  attr_reader :livros

  def initialize
    @vendas = []
    @livros = []
    @livros.extend Contador
  end

  def <<(livro)
   @livros << livro if livro
  end

  def total
    @livros.size
  end

  def vende(livro)
    @livros.delete livro
    @vendas << livro
  end

  def mais_barato_que(valor)
    @livros.select do |livro|
      livro.preco < valor
    end
  end

  def method_missing(name)
    matcher = name.to_s.match "(.+)_que_mais_vendeu_por_(.+)"
    if matcher
      tipo = matcher[1]
      campo = matcher[2].to_sym
      que_mais_vendeu_por(tipo, &campo)
    else
      super
    end
  end

  def respond_to?(name)
    name.to_s.match("(.+)_que_mais_vendeu_por_(.+)") || super
  end

  def que_mais_vendeu_por(tipo, &campo)
   @vendas.select { |produto| produto.matches? tipo }.sort {|v1,v2| quantidade_de_vendas_por(v1, &campo) <=>
     quantidade_de_vendas_por(v2, &campo)}.last
  end

  def quantidade_de_vendas_por(produto, &campo)
    @vendas.count { |venda| campo.call(venda) == campo.call(produto) }
  end

  def exporta_csv
    @livros.each do |livro|
      puts livro.to_csv
    end
  end
end
