def de_boas_vindas
  puts "Bem-vindo ao jogo da adivinhação"
  puts "Favor digite seu nome"
  nome = gets.strip
  puts "\n\n\n\n\n\n"
  puts "Começaremos o jogo para você, #{nome}"
  nome
end

def sorteia_numero_secreto(dificuldade)
  maximo = if dificuldade == 1
    30
  elsif dificuldade == 2
    60
  elsif dificuldade == 3
    100
  elsif dificuldade == 4
    150
  else dificuldade == 5
    200
  end
  puts "Escolhendo um número secreto entre 0 e #{maximo}..."
  sorteado = rand(maximo) + 1
  puts "Escolhido... que tal adivinhar hoje nosso número secreto?"
  sorteado
end

def pede_um_numero(chutes, tentativa, limite_de_tentativas)
  puts "\n\n\n\n\n\n"
  puts "Tentativa #{tentativa} de #{limite_de_tentativas}"
  puts "Chutes até agora: #{chutes.to_s}"
  puts "Entre com o número"
  chute = gets.strip
  puts "Será que você acertou? Você chutou #{chute}"
  chute.to_i
end

def verifica_se_acertou(numero_secreto, chute)
  acertou = chute == numero_secreto
  if acertou
    puts "Acertou!"
    true
  else
    maior = chute.to_i > numero_secreto
    if maior
      puts "Erooooo! O chute é maior que número secreto."
    else
      puts "Erooooo! O chute é menor que número secreto."
    end
    false
  end
end

def pede_dificuldade
  puts "Qual o nível de dificuldade que deseja? (1 fácil, 5 difícil)"
  dificuldade = gets.to_i
end

def nao_quer_jogar?
    puts "Deseja jogar novamente? (S/N)"
    quero_jogar = gets.strip
    quero_jogar.upcase == "N"
end

def joga(nome, dificuldade)
  chutes = []
  limite_de_tentativas = 5

  numero_secreto = sorteia_numero_secreto dificuldade
  pontos_ate_agora = 1000

  for tentativa in 1..limite_de_tentativas
    chute = pede_um_numero chutes, tentativa, limite_de_tentativas
    chutes << chute

    if nome.downcase == "lucas"
      puts "Acertou!"
      break
    end

    pontos_a_perder = (chute - numero_secreto).abs / 2
    pontos_ate_agora -= pontos_a_perder

    break if verifica_se_acertou numero_secreto, chute
  end

  puts "Você ganhou #{pontos_ate_agora} pontos."
end

nome = de_boas_vindas
dificuldade = pede_dificuldade

loop do
  joga nome, dificuldade
  break if nao_quer_jogar?
end
