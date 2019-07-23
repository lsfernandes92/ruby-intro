class heroi
  attr_accessor :linha, :coluna

  def calcula_nova_posicao(direcao)
    heroi = self.dup
    movimentos = {
      "W" => [-1, 0],
      "S" => [+1, 0],
      "A" => [0, -1],
      "D" => [0, +1]
    }
    movimento = movimentos[direcao]
    heroi.linha += movimento[0]
    heroi.coluna += movimento[1]
    heroi
  end
end
