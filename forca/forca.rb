require_relative 'ui'

def exibir_palavra_mascarada(chutes, palavra_secreta)
  mascara = ""
  for letra in palavra_secreta.chars
    if chutes.include? letra
      mascara += letra
    else
      mascara += "_"
    end
  end
  mascara
end

def sorteia_palavra_secreta
  avisa_escolhendo_palavra
  arquivo = File.read("dicionario.txt")
  palavras = arquivo.split("\n")
  numero_aleatorio = rand(palavras.size)
  palavra_sorteada = palavras[numero_aleatorio].downcase.strip
  avisa_palavra_escolhida palavra_sorteada
end

def pede_um_chute_valido(chutes, erros, mascara)
  cabecalho_de_tentativa chutes, erros, mascara
  loop do
    chute = pede_um_chute
    if chutes.include? chute
      avisa_chute_repetido chute
    else
      return chute
    end
  end
end

def joga(nome)
    palavra_secreta = sorteia_palavra_secreta

    erros = 0
    chutes = []
    pontos_ate_agora = 0

    while erros < 5
      mascara = exibir_palavra_mascarada chutes, palavra_secreta
      chute = pede_um_chute_valido chutes, erros, mascara
      chutes << chute

      chutou_uma_unica_letra = chute.size == 1
      if chutou_uma_unica_letra
        total_de_letras_encontradas = palavra_secreta.count chute
        if total_de_letras_encontradas > 0
          avisa_letra_encontrada chute, total_de_letras_encontradas
        else
          avisa_letra_nao_encontrada
          erros += 1
        end
      else
        acertou = chute == palavra_secreta
        if acertou
          avisa_acertou_palavra
          pontos_ate_agora += 100
          break
        else
          avisa_errou_palavra
          pontos_ate_agora -= 30
          erros += 1
        end
      end
    end
    pontos_ate_agora
end

def salva_rank(nome, pontos)
  conteudo = "#{nome}\n#{pontos}"
  File.write "rank.txt", conteudo
end

def le_rank
  campeao = File.read "rank.txt"
  campeao.split "\n"
end

def jogo_da_forca
  nome = da_boas_vindas
  pontos_totais = 0

  avisa_campeao_atual le_rank

  loop do
      pontos_totais += joga nome
      avisa_pontos pontos_totais

      if le_rank[1].to_i < pontos_totais
        salva_rank nome, pontos_totais
      end

      break if nao_quer_jogar?
  end
end
