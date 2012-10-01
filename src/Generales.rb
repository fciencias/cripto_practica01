# -*- coding: utf-8 -*-
=begin
=end

require './Manejador'

class Generales
  
  manejador = nil
  TAMANO = 26
  @texto = nil

  ##
  #
  def initialize(_ruta_archivo)
    manejador = Manejador.new(_ruta_archivo)
    manejador.leer_archivo
    @texto = manejador.contenido
  end


  def frecuencias
    tabla = {"A"=>0,"B"=>1,"C"=>2,"D"=>3,"E"=>4,"F"=>5,"G"=>6,"H"=>7,"I"=>8,"J"=>9,
      "K"=>10,"L"=>11,"M"=>12,"N"=>13,"O"=>14,"P"=>15,"Q"=>16,"R"=>17,"S"=>18,"T"=>19,"U"=>20,
      "V"=>21,"W"=>22,"X"=>23,"Y"=>24,"Z"=>25}
    @texto.each_char { |c|
      valor = tabla[c]
      if valor != nil
        tabla[c] = valor.succ
      end }
    puts tabla.to_s
  end


  ##
  #
  def selection_sort(tabla_hash)
    ordenados = tabla_hash.to_a 
    for i in 0...TAMANO-2
      min = i
      for j in i+1...TAMANO-1
        if (ordenados[j])[2] < (ordenados[min])[2]
          min = j
        end
        # swap y asignacion
      end
    end
  end



  private :selection_sort

  attr_reader :texto
  
end #class

grl = Generales.new("texto.txt")
grl.frecuencias
