# Jogo Da Velha Usando Minimax


> José Luiz Corrêa Junior - [GitHub](https://github.com/juninhoojl) - <juninhopc@icloud.com>
> 
> Felippe Mangueira da Silva Sposito - [GitHub](https://github.com/FelippeS) - <felippesposito@hotmail.com>
> > Escrito em: Ruby


###Princípios básicos do funcionamento

O programa utiliza cálculo de possibilidades através do algoritmo de lógica minimax para prever os movimentos básicos do jogo da velha, e assim simular jogadas realistas.
![Minimax](img/minimax.png)

####Arquivos e módulos
O programa é composto de apenas um arquivo, `jogo.rb` , que consiste de um código ruby responsável por calcular as alternativas de jogada e interagir com o jogador.

##Linguagem
A linguagem utilizada foi Ruby, pela riqueza de métodos e velocidade de escrita de código (dinamicidade). A possibilidade de uso de métodos de bibliotecas prontas também foi considerada.

###Código
O código foi dividido em métodos que serão colocados abaixo:

####mostra_fim_jogo
Imprime os resultados do jogo;

####jogada_humano
Método que recebe o input das jogadas do usuário; manda depois para o método de cálculo de possibilidades; Também verifica jogadas inválidas.

####