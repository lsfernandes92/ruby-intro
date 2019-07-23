require_relative 'ui'
require_relative 'heroi'

def le_mapa(numero)
  arquivo = "mapa#{numero}.txt"
  texto = File.read(arquivo)
  mapa = texto.split("\n")
end

def encontra_jogador(mapa)
    caracter_do_heroi = "H"
    mapa.each_with_index do |linha_atual, linha|
        coluna_do_heroi = linha_atual.index caracter_do_heroi
        if coluna_do_heroi
          heroi = heroi.new
          heroi.linha = linha
          heroi.coluna = coluna_do_heroi
          return heroi
        end
    end
    nil
end

def posicao_valida?(mapa, nova_posicao)
  linhas = mapa.size
  colunas = mapa[0].size

  estourou_linhas = nova_posicao[0] < 0 || nova_posicao[0] >= linhas
  estoutou_coluna = nova_posicao[1] < 0 || nova_posicao[1] >= colunas

  if estoutou_coluna || estourou_linhas
    return false
  end
  if mapa[nova_posicao[0]][nova_posicao[1]] == "X"
    return false
  end
  if mapa[nova_posicao[0]][nova_posicao[1]] == "F"
    return false
  end

  true
end

def soma_vetor(vetor1, vetor2)
  [vetor1[0] + vetor2[0], vetor1[1] + vetor2[1]]
end

def posicoes_validas_a_partir_de(mapa, novo_mapa, posicao)
  posicoes = []
  movimentos = [[0, +1], [0, -1], [+1, 0], [-1, 0]]
  movimentos.each do |movimento|
    novo_movimento = soma_vetor posicao, movimento
    if posicao_valida?(mapa, novo_movimento) && posicao_valida?(novo_mapa, novo_movimento)
      posicoes << novo_movimento
    end
  end
  posicoes
end

def copia_mapa(mapa)
  novo_mapa = mapa.join("\n").tr("F", " ").split("\n")
end

def move_fantasma(mapa, novo_mapa, linha, coluna)
  posicoes = posicoes_validas_a_partir_de mapa, novo_mapa, [linha, coluna]
  if posicoes.empty?
    return
  end
  aleatorio = rand posicoes.size
  posicao = posicoes[aleatorio]
  mapa[linha][coluna] = " "
  novo_mapa[posicao[0]][posicao[1]] = "F"
end

def move_fantasmas(mapa)
    caracter_do_fantasma = "F"
    novo_mapa = copia_mapa mapa
    mapa.each_with_index do |linha_atual, linha|
      linha_atual.chars.each_with_index do |caracter_atual, coluna|
        eh_fantasma = caracter_atual == caracter_do_fantasma
        if eh_fantasma
          move_fantasma mapa, novo_mapa, linha, coluna
        end
      end
    end
    novo_mapa
end

def jogador_perdeu?(mapa)
  perdeu = !encontra_jogador(mapa)
end

def joga(nome)
  mapa = le_mapa(2)
  while true
    desenha mapa
    direcao = pede_movimento
    
    heroi = encontra_jogador mapa
    nova_posicao = heroi.calcula_nova_posicao direcao
    if !posicao_valida? mapa, nova_posicao
      next
    end

    mapa[heroi.linha][heroi.coluna] = " "
    mapa[nova_posicao[0]][nova_posicao[1]] = "H"

    mapa = move_fantasmas mapa
    if jogador_perdeu? mapa
      game_over
      break
    end
  end
end

def inicia_fogefoge
  nome = da_boas_vindas
  joga nome
end
