require_relative 'estoque'
require_relative 'produto'
require_relative 'impresso'

class Livro < Produto
  include Impresso
  attr_reader :possui_sobrecapa

  def initialize(titulo, preco, ano_lancamento, possui_reimpressao, possui_sobrecapa, editora)
    super(titulo, preco, ano_lancamento, editora)
    @possui_reimpressao = possui_reimpressao
    @possui_sobrecapa = possui_sobrecapa
  end

  def matches?(query)
    ["livro", "impresso"].include? query
  end
end
