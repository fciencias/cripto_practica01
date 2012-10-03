require './Manejador'
require './Generales'
require './Cesar'
require './Vigenere'

class Principal
  
  MENU = "[0]  Salir \n"+
         "[1]  Frecuencias \n"+
         "[2]  N-Gramas \n"+
         "[3]  Cifrar Cesar \n"+
         "[4]  Descifrar Cesar \n"+
         "[5]  Cifrar Vigenere \n"+
         "[6]  Descifrar Vigenere \n"
  
  def initialize
    puts "Hello!"
    STDOUT.flush
  end

  ##
  #
  def correr
    puts MENU
    print "Que Deseas Hacer? \n>> "
    opcion = gets.chomp.to_i
    if opcion == 0
      puts "GOD BYE...."
      return opcion
    elsif opcion > 6
      puts "Opcion no registrada."
      return 0 
    end
    salida = 0
    puts "Indicar ruta del archivo"
    ruta = gets.chomp
    #puts ruta
    managment = Manejador.new(ruta)
    if opcion == 1
      grals = Generales.new(managment)
      grals.frecuencias(true)
      salida = 1
    elsif opcion == 2
      puts "Pendiente......"
      salida = 2
    elsif opcion == 3
      cesar = Cesar.new(managment, true)
      puts "Dame el desplazamiento. "
      desplazamiento = gets.chomp.to_i
      cesar.cifrar_Cesar(desplazamiento)
      system("rm texto_limpio.txt")
      salida = 3
    elsif opcion == 4
      cesar = Cesar.new(managment, false)
      puts "Dame el desplazamiento. "
      desplazamiento = gets.chomp.to_i
      cesar.des_encriptar_cesar(desplazamiento)
      salida = 4
    elsif opcion == 5
      vigen = Vigenere.new(managment, true)
      puts "Dame la llave del cifrado."
      _key = gets.chomp.upcase
      vigen.cifra_vigenere(_key)
      system("rm texto_limpio.txt")
      salida = 5
    elsif opcion == 6
      vigen = Vigenere.new(managment, false)
      puts "Dame la llave del cifrado."
      _key = gets.chomp.upcase
      vigen.des_cifra_vigenere(_key)
      salida = 6
    end
    return salida
  end
  
end

if __FILE__ == $0
  
  _main = Principal.new
  status = -1
  while status != 0
    status = _main.correr
  end
  
end