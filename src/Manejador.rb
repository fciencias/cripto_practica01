# -*- coding: utf-8 -*-
=begin
=end

class Manejador
  
  TEXTO_LIMPIO = "texto_limpio.txt"
  
  ## Crea una instancia de la clase manejador, la cual se encarga
  # de manejar los archivos, Abrir archivos, Guardar archivos 
  # y limpiar archivos.
  def initialize(ruta)
    aux = File.expand_path(ruta)
    @ruta_archivo = aux
    @contenido = ""
  end

  attr_reader :contenido
  
  ## Se encarga de abrir el archivo que se especifico
  # cuando se creo la clase en el nombre de la ruta.
  # nombre: se abre por omision el archivo que se especifico al crear la
  # instancia o se le da un nuevo archivo para abrir.
  def leer_archivo(nombre="#{@ruta_archivo}")
    puts "Leyendo archivo..."
    valido = verificador_ruta
    if valido
      puts "La ruta es valida"
      File.open(nombre, 'r') do |archivo|
        while linea = archivo.gets
          @contenido.concat(linea)
        end
      end
    end
  end
  
  ## Dado un texto en español se encarga de pasarlo en limpio,
  # esto es sin signos de puntuacion y sin acentos, ademas de 
  # las letras usadas en español como la ñ, etc.
  def limpiar_texto
    valido = verificador_ruta
    if valido
      puts "Limpiando..."
      system("sed 'y/\á\é\í\ó\ú\ñ\ü\Á\É\Í\Ó\Ú\Ñ/aeiounuaeioun/' #{@ruta_archivo} > tmp")
      system("cat tmp | tr -d '.' > tmp2")
      system("cat tmp2 | tr -d ',' > tmp")
      system("cat tmp | tr -d '(' > tmp2")
      system("cat tmp2 | tr -d ')' > tmp")
      system("cat tmp | tr -d ':' > tmp2")
      system("cat tmp2 | tr -d ';' > tmp")
      system("cat tmp | tr -d '\n' > tmp2")
      system("sed 's/[ ]//g' tmp2 > tmp3")
      system("sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/' tmp3 > tmp4")
      system("cat tmp4 | tr -d '\n' > tmp")
      system("cat tmp > #{TEXTO_LIMPIO}")
      system("rm tmp ; rm tmp2")
      system("rm tmp3; rm tmp4")
    end
  end
  
  ## Se encarga de verificar si la ruta dada
  # es un archivo valido, si es un archivo valido
  # regresa true.
  def verificador_ruta
    file = nil
    begin
      file = File.open("#{@ruta_archivo}", 'r')
    rescue SystemCallError
      @contenido = nil
      puts "Error!\nEl archivo no se puede leer."
    end
    if file != nil
      return true
    else 
      return false
    end
  end
  
  ## Se encarga de guardar archivos en el disco duro.
  # nombre_archivo: El nombre con que se guardara el archivo en el disco.
  # in_file: El contenido del archivo.
  def guardar_archivo(nombre_archivo, in_file="#{@contenido}")
    puts "Guardando..."
    nombre = nombre_archivo + ".txt"
    File.open(nombre,'w') do |archivo|
      archivo.puts in_file
    end
    puts "Guarde el archivo en: " + nombre
  end
  
  private :verificador_ruta
  
end
