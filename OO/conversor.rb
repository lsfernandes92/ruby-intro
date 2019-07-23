class Conversor
  def string_para_alfanumerico(titulo_livro)
    titulo_livro.gsub(/[^\w\s]/,'')
  end
end
