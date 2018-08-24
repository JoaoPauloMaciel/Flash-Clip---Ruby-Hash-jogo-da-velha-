class Cachorro
 def setar_nome
   @nome = "Roger"
 end
    
 def falar
   puts "#{@nome} Late!"
  end
end

#as variaveis de instancia so podem ser usadas dentro da classe mas em todos os metodos

roger = Cachorro.new

roger.setar_nome
roger.falar


