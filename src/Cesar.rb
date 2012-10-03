# -*- coding: utf-8 -*-
=begin
=end

require './Manejador'

class Cesar

  TEXTO_LIMPIO = "texto_limpio.txt"
  CESAR_EN = "texto_cifrado_cesar"
  CESAR_DES = "texto_cesar_desencriptado"
  @texto = nil
  @manejador = nil

  ## Crea una instancia de la clase Cesar, la cual se encarga de
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
      @manejador.leer_archivo
      @texto = @manejador.contenido
    end
  end
  
  ## Dado un numero que es el desplazamiento,
  # cesar se encarga de aplicar la funcion f(x) = x + desplazamiento
  # y guarda el texto cifrado en un archivo llamado 
  # "texto_cifrado_cesar.txt"
  def cifrar_Cesar(_desplazamiento)
    texto_cifrado = ""
    alfabeto = "abcdefghijklmnopqrstuvwxyz"
    mayusculas = alfabeto.upcase
    @texto.each_char { |car|
      indice = alfabeto.index(car)
      desplazamiento_cifrar = (indice + _desplazamiento) % 26
      texto_cifrado << mayusculas[desplazamiento_cifrar]
    }
    @manejador.guardar_archivo("#{CESAR_EN}", texto_cifrado)
    puts texto_cifrado
  end
  
  
  ## 
  #
  #
  def des_encriptar_cesar(_desplazamiento)
    texto_desencriptado = ""
    mayusculas = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    minusculas = mayusculas.downcase
    @texto.each_char { |car|
      #puts car
      indice = mayusculas.index(car)
      if indice != nil
        desplazamiento_cifrar = (indice - _desplazamiento) % 26
        texto_desencriptado << minusculas[desplazamiento_cifrar]
      end
    }
    @manejador.guardar_archivo("#{CESAR_DES}", texto_desencriptado)
    puts texto_desencriptado
  end

  attr_reader :texto

end #end class cesar
