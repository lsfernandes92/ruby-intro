require_relative 'estoque'
require_relative 'produto'

class EBook < Produto

  def initialize(titulo, preco, ano_lancamento, editora)
    super(titulo, preco, ano_lancamento, editora)
  end

  def possui_reimpressao?
    @possui_reimpressao
  end

  def matches?(query)
    ["ebook", "digital"].include? query
  end
end
