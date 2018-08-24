class Cachorro
 def setar_nome
   @nome = "Roger"
 end
    
 def falar
   puts "#{@nome} Late!"
  end
end

#as variaveis de instancia so podem ser usadas dentro da classe mas em todos os metodos

roger = Cachorro.new('X', Array.new(9))

roger.setar_nome
roger.falar


