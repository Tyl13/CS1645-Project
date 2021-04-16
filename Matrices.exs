defmodule Matrices do
  def mapsFun(x) do
  	matrix_a =map_A(x,x)
  	matrix_b =map_B(x,x)
  	empty = empty_map(x,x)
  	IO.inspect Map.fetch(matrix_a, {x,x})
  	IO.inspect Map.fetch(matrix_b, {x,x})
  	IO.inspect Map.fetch(empty, {x,x})
  end

  def map_A(size_x, size_y) do
    Enum.reduce(1..size_x, %{}, fn x, acc ->
      Enum.reduce(1..size_y, acc, fn y, acc ->
          Map.put(acc, {x, y}, x*size_x+y)
      end)
    end)
  end

  def map_B(size_x, size_y) do
    Enum.reduce(1..size_x, %{}, fn x, acc ->
      Enum.reduce(1..size_y, acc, fn y, acc ->
          Map.put(acc, {x, y}, y*size_y+x)
      end)
    end)
  end

  def empty_map(size_x, size_y) do
    Enum.reduce(1..size_x, %{}, fn x, acc ->
      Enum.reduce(1..size_y, acc, fn y, acc ->
          Map.put(acc, {x, y}, 0)
      end)
    end)
  end

end

Matrices.mapsFun(20)
