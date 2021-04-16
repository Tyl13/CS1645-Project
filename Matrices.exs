defmodule Matrices do
  def mapsFun(x) do
  	matrix_a =map_A(x)
    IO.puts "A done"
    weight = map_A(x)
    IO.puts "Weight done"
  	matrix_b =map_B(x)
    IO.puts "B done"
    outputArray = empty_map(x)
    IO.puts "empty done"
    output = Enum.sum(updateTwo(matrix_a, matrix_b, weight, outputArray, 0, 0, x))

  end

  def map_A(size) do
    Stream.map(0..(size*size)-1, &(Integer.floor_div((&1), size)*size+Integer.mod((&1), size)))
  end

  def map_B(size) do
    Stream.map(0..(size*size)-1, &(Integer.mod((&1), size)*size+Integer.mod((&1), size)))
  end

  def update(inputArrayA, weight, outputArray, i, j, size) do
    IO.puts "In update"
    Stream.map(0..size-1, &(Enum.at(inputArrayA, i*size+&1)*Enum.at(weight, &1*size+j)))
    |> Enum.sum
  end

  def updateTwo(inputArrayA, inputArrayB, weight, outputArray, i, j, size) do
    IO.puts i
    IO.puts j
    cond do
      j == size and i != size ->
        updateTwo(inputArrayA, inputArrayB, weight, outputArray, i+1, 0, size)
      j < size and i < size->
        partialSum = update(inputArrayA, weight, outputArray, i, j, size)
        IO.puts "Done with update"
        partialSum = partialSum+Enum.at(inputArrayB, i*size+j)
        IO.puts partialSum
        IO.puts "Done with B"
        outputArray = Map.put(outputArray, {i, j}, partialSum)
        IO.puts "About to update"
        updateTwo(inputArrayA, inputArrayB, weight, outputArray, i, j+1, size)
      i == size ->
        outputArrayC = outputArray
    end
  end

  def empty_map(x) do
    Stream.cycle(0..0)
    |> Enum.take(x*x)
    |> Enum.chunk_every(1)
    |> Map.new(fn [Integer.floor_div(k, x), Integer.mod(k, x)] -> {k} end)
  end

end
