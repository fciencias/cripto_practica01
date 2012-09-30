=begin
=end

class Manejador
  
  TEXTO_LIMPIO = "texto_limpio.txt"
  attr_reader :contenido
  
  ## Crea una instancia de la clase manejador, la cual se encarga
  # de manejar los archivos, Abrir archivos, Guardar archivos 
  # y limpiar archivos.
  def initialize(ruta)
    aux = File.expand_path(ruta)
    @ruta_archivo = aux
    @contenido = ""
  end
  
  ## Se encarga de abrir el archivo que se especifico
  # cuando se creo la clase en el nombre de la ruta.
  def leer_archivo
    puts "Leyendo archivo..."
    file = nil
    valido = verificador_ruta
    if valido
      file = File.open("#{@ruta_archivo}", 'r')
      file do |archivo|
      while linea = archivo.gets
        @contenido.concat(linea)
      end
    end
  end
  
  ## Dado untexto en español se encarga de pasarlo en limpio,
  # esto es sin signos de puntuacion y sin acentos, ademas de 
  # las letras usadas en español como la ñ, etc.
  def limpiar_texto
    valido = verificador_ruta
    if valido
      puts "Limpiando..."
      system("sed 'y/\á\é\í\ó\ú\ñ\ü\Á\É\Í\Ó\Ú\Ñ/aeiounuAEIOUN/' #{@ruta_archivo} > tmp")
      system("cat tmp | tr -d '.' > tmp2")
      system("cat tmp2 | tr -d ',' > tmp")
      system("cat tmp | tr -d '(' > tmp2")
      system("cat tmp2 | tr -d ')' > tmp")
      system("cat tmp | tr -d ':' > tmp2")
      system("cat tmp2 | tr -d ';' > tmp")
      system("sed 's/[ ]//g' tmp > tmp3")
      system("cat tmp3 | tr -d '\n' > tmp")
      system("cat tmp > #{TEXTO_LIMPIO}")
      system("rm tmp2")
      system("rm tmp3")
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
  
  ##
  #
  def guardar_archivo(nombre_archivo)
    puts "Guardando..."
    nombre = nombre_archivo + ".txt"
    File.open(nombre,'w') do |archivo|
      archivo.puts @contenido
    end
  end
  
end