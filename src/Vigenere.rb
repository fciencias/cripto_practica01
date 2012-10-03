=begin
=end

require './Manejador'

class Vigenere
  
  @manejador = nil
  @texto = nil
  VIG_EN = "texto_vigenere_encriptado"
  VIG_DES = "texto_vigenere_desencriptado"
  TEXTO_LIMPIO = "texto_limpio.txt"
  MINUSCULAS = "abcdefghijklmnopqrstuvwxyz"
  MAYUSCULAS = MINUSCULAS.upcase
  
  ## Crea una instancia de la clase Vigenere, la cual se encarga de
  # leer un archivo y limpiarlo de caracteres especiales.
  # _ruta: es la ruta del archivo a leer
  # encriptar: un booleano que nos indica si el archivo se va a encriptar
  # o false si el archivo esta encriptado.
  def initialize(arg_manejador, encriptar)
    @manejador = arg_manejador
    if encriptar
      @manejador.limpiar_texto
      @manejador.leer_archivo("#{TEXTO_LIMPIO}")
      @texto = @manejador.contenido
    else
      @manejador.leer_archivo("#{VIG_EN}.txt")
      @texto = @manejador.contenido
    end
  end
  
  ##
  #
  def cifra_vigenere(llave)
    cifrado = ""
    longitud = @texto.length
    0.upto(longitud-1) do |j|
      i = j % (llave.size)
      alfabeto_ver = corrimiento(llave[i])
      car_cifrar = "" << @texto[j]
      posicion = MINUSCULAS.index(car_cifrar)
      a = alfabeto_ver[posicion]
      cifrado.concat(a)
    end
    @manejador.guardar_archivo("#{VIG_EN}", cifrado)
    puts cifrado
  end
  
  ##
  #
  def des_cifra_vigenere(llave)
    claro = ""
    longitud = @texto.length
    @texto.chomp!
    0.upto(longitud - 2) do |i|
      j = i % (llave.size)
      alfabeto_ver = corrimiento(llave[j])
      car_cifrado = "" << @texto[i]
      posicion = alfabeto_ver.index(car_cifrado)
      b = MINUSCULAS[posicion]
      claro.concat(b)
    end
    @manejador.guardar_archivo("#{VIG_DES}", claro)
    puts claro
  end


  def corrimiento(car)
    tam = MINUSCULAS.length
    indice = MAYUSCULAS.index(car)
    nueva =  MAYUSCULAS[indice..tam]
    nueva << MAYUSCULAS[0...indice]
    return nueva
  end

  private :corrimiento
  
end
