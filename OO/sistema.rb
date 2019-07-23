require_relative 'livro'
require_relative 'revista'
require_relative 'ebook'
require_relative 'estoque'

def news_letter(livro)
  if livro.ano_lancamento < 2000
    puts "Newsletter"
    puts livro.titulo
    puts livro.preco
  end
end

estoque = Estoque.new
algoritmos = Livro.new("Algoritmos", 100, 1998, true, true, "Algo Rithym")
ruby = Livro.new("Ruby Orientado ao Cavalo", 100, 1998, true, true, "Editora Horseman")
programmer = Livro.new("Programador Go(Horse)", 5, 2017, false, false, "BOOOOORA")
revistona = Revista.new("Revistona de Ruby", 30, 2017, false, 3, "Revolta Crazy")
online_arquitetura = EBook.new("Introdução a Arquitetura e Design de Software", 50, 2012, "editora digital, né?")

estoque << algoritmos << algoritmos << ruby << programmer << online_arquitetura << ruby << ruby << revistona << revistona << online_arquitetura

estoque.vende ruby
estoque.vende algoritmos
estoque.vende algoritmos
estoque.vende revistona
estoque.vende online_arquitetura
puts estoque.livro_que_mais_vendeu_por_titulo.titulo
puts estoque.revista_que_mais_vendeu_por_titulo.titulo
puts estoque.ebook_que_mais_vendeu_por_titulo.titulo
