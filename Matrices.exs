defmodule Matrices do
  def mapsFun(x) do
  	matrix_a =map_A(x)
    weight = map_A(x)
  	matrix_b =map_B(x)
    Enum.to_list(matrix_a)
    Enum.to_list(matrix_b)
  end

  def map_A(size) do
    Stream.map(1..(size*size), &(Integer.floor_div((&1-1), size)*size+Integer.mod((&1-1), size)))
  end

  def map_B(size) do
    Stream.map(1..(size*size), &(Integer.mod((&1-1), size)*size+Integer.mod((&1-1), size)))
  end

end

Matrices.mapsFun(20)
