def metodo_ou
    false || true
  end

position = 7

puts position % 3

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

    #sendo que o tabuleiro é um array de array
    #seta a posicao em zero, seria como uma linha e os outros colunas
      ( board[positions[0]] == board[positions[1]] &&
        board[positions[1]] == board[positions[2]] &&
        board[positions[0]] ) || nil
    }.compact.first

=begin
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
=end