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
  def initialize(arg_manejador)
    manejador = arg_manejador
    manejador.leer_archivo
    @texto = manejador.contenido
  end

  ## Dado un texto cifrado nos permite contar el numero de veces
  # que se repite cada palabra en el texto, recibe como parametro
  # la indicacion true para que imprima la lista de frecuencias 
  # ordenadas
  def frecuencias(_imprime)
    tabla = {"A"=>0,"B"=>0,"C"=>0,"D"=>0,"E"=>0,"F"=>0,"G"=>0,"H"=>0,"I"=>0,
      "J"=>0,"K"=>0,"L"=>0,"M"=>0,"N"=>0,"O"=>0,"P"=>0,"Q"=>0,"R"=>0,
      "S"=>0,"T"=>0,"U"=>0,"V"=>0,"W"=>0,"X"=>0,"Y"=>0,"Z"=>0}
    @texto.each_char {|c|
      valor = tabla[c]
      if valor != nil
        tabla[c] = valor.succ
      end}
      sorted = selection_sort(tabla)
      if _imprime
        sorted.each {|ele| 
          puts ele[0] + " -- " + ele[1].to_s
        }
      end
      return sorted
  end

  ##
  def n_gramas()
    for i in 2...8
      busca_n_gramas(i)
    end
  end


  ##
  #
  def busca_n_gramas(indice_)
    encontrados = Array.new
    tamano_texto = @texto.length
    n_gramas = @texto.clone
    if indice_ > 7 || indice_ < 2
      puts "Solo puedo darte de 2 a 7 -gramas"
      return
    end
    arreglo = frecuencias(false)
    10.times do |i|
      frecuen = arreglo[i]
      letra = frecuen[0]
      caracter = letra.dup
      j = 0
      sig = nil
      ant = nil
      while true
        en_texto = "" << n_gramas[j]
        if caracter.eql?(en_texto)
          sig = n_gramas[j...j+indice_]
          ant = n_gramas[j+1-indice_..j]
          rep_s = n_gramas.scan(sig).size
          rep_a = n_gramas.scan(ant).size
          if rep_s > 2
            salida = sig + " -- " + rep_s.to_s
            salida2 = ant + " -- " + rep_a.to_s
            puts salida
            puts salida2
          end
          break
        end#if
        j = j.succ  
      end#e while
    end
    return encontrados
  end

  ## Ordena una tabla has usando el algorito de selection sort, que
  # aunque no es el mejor al ser pocos casos no es tan grave y es muy 
  # facil de implementar.
  def selection_sort(tabla_hash)
    ordenados = tabla_hash.to_a 
    for i in 0..TAMANO-2
      max = i
      for j in i+1..TAMANO-1
        if (ordenados[j])[1] > (ordenados[max])[1]
          max = j
        end
        if (ordenados[i])[1] < (ordenados[max])[1]
          aux = ordenados[i]
          ordenados[i] = ordenados[max]
          ordenados[max] = aux
        end
      end
    end
    return ordenados
  end


  private :selection_sort

  ## Metodo de acceso al texto.
  attr_reader :texto
  
end #class

#mn = Manejador.new("vigenere_completo.txt")
#grl = Generales.new(mn)
#grl.frecuencias(true)
#grl.n_gramas
#puts ar[0]
#n = ar.length
#n.times do |i|
#  puts ar[i]
#end