require 'benchmark'

class GameState
  #criacao do metodo de acesso para varias variaveis de instacia, leitura e escrita
  attr_accessor :jogador_atual, :board, :moves, :rank

#classe Cache
  class Cache
    #criacao do metodo de acesso, leitura e escrita
    attr_accessor :states
    def initialize
      @states = {}
    end
  end

  class << self
    #criacao do metodo de acesso, leitura e escrita
    attr_accessor :cache

  end
  self.cache = Cache.new

  #metodo initialize, para definicao dos parametros
  #quando for criado um objeto ja chama esse metodo, automaticamente
  def initialize(jogador_atual, board)
    #metodo self para chamar o metodo de acesso das variaveis de instancia
    self.jogador_atual = jogador_atual
    self.board = board
    self.moves = []
  end
  
  #Recebe true or false
  def rank
    @rank ||= resultado_final || resultado_intermediario
  end

  #Metodo chamando quando o turno pertence ao computador
  def proximo_movimento
  #Uso da nave espacial (<=>)
  #retorna -1 se a < b
  #retorna 0 se a = b
  #retorna 1 se a > b

    moves.max{ |a, b| a.rank <=> b.rank }
  end

#Metodo para retornar quem foi o vencedor
  def resultado_final
    #somente se ja estiver chegado no fim do jogo
    #ja que tambem eh usado para checar melhor opcao
    if fim_jogo?
      #retorna 0 se deu velha
      return 0 if velha?
      #retorna 1 se X ganhou e -1 se O
      vencedor == "X" ? 1 : -1
    end
  end

#Metodo que confere se acabou
  def fim_jogo?
  #se teve ganhador ou deu velha retorna true
    vencedor || velha?
  end

#metodo que confere se deu velha e retorna true ou false
  def velha?
    #Tira nil com .compact e conta quantos elementos tem
    board.compact.size == 9 && vencedor.nil?

  end


#Metodo para mostrar os resultados intermediarios para cada jogada "simulada"
  def resultado_intermediario
    # recursion, baby
    ranks = moves.collect{ |game_state| game_state.rank }
    if jogador_atual == 'X'
      #retorna ranks.max se for o computador
      ranks.max
    else
      #retorna ranks.min se for a jogada do humano
      ranks.min
    end
  end  

#funcao com as combinacoes vencedoras
  def vencedor

    @vencedor ||= [
     # combinacoes horizonatal
     [0, 1, 2],
     [3, 4, 5],
     [6, 7, 8],

     # combinacoes vertical
     [0, 3, 6],
     [1, 4, 7],
     [2, 5, 8],

     # combinacoes diagonal
     [0, 4, 8],
     [6, 4, 2]
    ].collect { |positions|
      ( board[positions[0]] == board[positions[1]] &&
        board[positions[1]] == board[positions[2]] &&
        board[positions[0]] ) || nil
    }.compact.first
    #@vencedor recebe X se ele tiver ganhado, ou o que completou a coluna
    #se nao teve ganhador, permanece nil
  end

end

#Classe que verifica as possibilidades futuras
class ArvoreJogo
  def generate
    #Ja passa o jogador atual e o tabuleiro no metodo initialize
    initial_game_state = GameState.new('X', Array.new(9))
    gerador_movimentos(initial_game_state)
    initial_game_state
  end



  def gerador_movimentos(game_state)
    next_player = (game_state.jogador_atual == 'X' ? 'O' : 'X')
    game_state.board.each_with_index do |player_at_position, position|
      unless player_at_position
        next_board = game_state.board.dup
        next_board[position] = game_state.jogador_atual
        next_game_state = (GameState.cache.states[next_board] ||= GameState.new(next_player, next_board))
        game_state.moves << next_game_state
        gerador_movimentos(next_game_state)
      end
    end
  end
end

#Classe jogo
class Game
  #Metodo para iniciar jogo
  def initialize
    puts Benchmark.measure{ @game_state = @initial_game_state = ArvoreJogo.new.generate }
  end

  #Metodo para caso seja fim de jogo
  def turn
    if @game_state.fim_jogo?
      mostra_fim_jogo

      puts "Jogar novamente? (Sim)(Nao)"
      answer = gets.downcase
      if answer.downcase.strip == 'sim' || answer.downcase.strip == 's'
        #cria novo tabuleiro
        @game_state = @initial_game_state
        turn
      else#caso a resposta seja nao
        exit
      end
    end

    #checa a quem pertence a proxima jogada
    #Se pertence 
    if @game_state.jogador_atual == 'X'
      puts "\n•••••••••••••••••••••••"
      @game_state = @game_state.proximo_movimento
      puts "Jogada do computador(X):"
      #mostra o tabuleiro com a jogada do computador
      mostra_tabuleiro
      turn#Vai para o proximo turno
    else#se tiver sido a jogada do humano
      jogada_humano
      puts "Seu movimento:"
      #mostra o tabuleiro com a jogada do humano
      mostra_tabuleiro
      puts ""
      turn#vai para o proximo turno
    end
  end
  
  #Metodo para mostrar o tabuleiro
  def mostra_tabuleiro
    #Inicia string vazia para receber as entradas
    saida = ""
    #Laco de o ate 8 para as posicoes do tabuleiro
    0.upto(8) do |posicao|
      #Acrescente coisas na string de saida
      saida << " #{@game_state.board[posicao] || posicao} "

      #confere o resto da divisao por 3
      case posicao % 3
      #Se for 0 ou 1, precisa do pipe pq eh coluna esquerda ou meio
      when 0, 1 then saida << "|"
      #Se for 2, precisa pular linha depois e ja colocar a linha
      when 2 then saida << "\n-----------\n" unless posicao == 8
      end
    end
    #printa a string que contem o tabuleiro
    puts saida
  end

#Metodo para pegar posicao escolhida pelo jogador
  def jogada_humano
    puts "Digite o numero para marcar:"
    #Le entrada do usuario
    position = gets
    #Confere se o movimento é valido, retorna true ou false
    move = @game_state.moves.find{ |game_state| game_state.board[position.to_i] == 'O' }
    if move#Caso seja uma posicao valida
      @game_state = move
    else#Retorna metodo ate posicao valida
      puts "Movimento invalido!"
      #chama o metodo jogada_humano de novo
      jogada_humano
    end
  end

#Metodo para mostar resultado do jogo
def mostra_fim_jogo
    #caso seja velha
    if @game_state.velha?
      puts "Deu velha!"
    #caso X(computador) ganhou
    elsif @game_state.vencedor == 'X'
      puts "X Ganhou"
    #caso O(Jogador) ganhou
    else
      puts "O Ganhou"
    end
  end
end

#Novo turno
Game.new.turn
