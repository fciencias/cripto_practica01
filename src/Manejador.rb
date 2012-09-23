=begin
=end

class Manejador
  
  TEXTO_LIMPIO = "texto_limpio.txt"
  attr_reader :contenido
  
  def initialize(ruta)
    aux = File.expand_path(ruta)
    @ruta_archivo = aux
    @contenido = ""
  end
  
  def leer_archivo
    puts "Leyendo archivo..."
    file = nil
    begin
      file = File.open("#{@ruta_archivo}", 'r')
    rescue SystemCallError
      @contenido = nil
      puts "Error!\nEl archivo no se puede leer."
    end
    limpiar_texto
    File.open(TEXTO_LIMPIO,'r') do |archivo|
      while linea = archivo.gets
        @contenido.concat(linea)
      end
    end
    system("rm #{TEXTO_LIMPIO}")
  end
    
  
end