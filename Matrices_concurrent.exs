defmodule Matrices do
  def main(matrix, numberProcesses) do
    Task.async_stream(1..numberProcesses, Matrices, :mapsFun, [matrix, numberProcesses], timeout: 1000000) |> Enum.map(fn{:ok, result} -> result end) |> Enum.sum()
  end
  def mapsFun(id, size, num_of_processes) do
    id = id-1
  	matrix_a =map_A(size)
    weight = map_A(size)
  	matrix_b =map_B(size)
    outputArray = Stream.map(0..0, fn x -> (x*0) end)
    # spawn process
    # do math to get starting and ending points for each process.
    # convert starting point into i and j spot
    total = size*size
    # size = 100
    # num_process = 9
    # multi = 11
    # remainder = 1
    multi = div(size, num_of_processes)
    remainder = rem(size, num_of_processes)
    starting_spot = id*multi
    ending_spot = if id != (num_of_processes-1), do: multi*(id+1), else: multi*(id+1)+remainder
    output = Enum.sum(updateTwo(matrix_a, matrix_b, weight, outputArray, starting_spot, 0, size, ending_spot))
    # communicate partial sums back, and then sum together to get final sum.

  end

  def map_A(size) do
    Stream.map(0..(size*size)-1, &(Integer.floor_div((&1), size)*size+Integer.mod((&1), size)))
  end

  def map_B(size) do
    Stream.map(0..(size*size)-1, &(Integer.mod((&1), size)*size+Integer.mod((&1), size)))
  end

  def update(inputArrayA, weight, outputArray, i, j, size) do
    Stream.map(0..size-1, &(Enum.at(inputArrayA, i*size+&1)*Enum.at(weight, &1*size+j)))
    |> Enum.sum
    # This sums the stream before this and returns that:
    # for(k=0;k<NROW;k++)
    # {
    # 	outputArrayC[i][j]+=inputArrayA[i][k]*Weight[k][j];
    # }
    # outputArrayC[i][j] is returned.
  end

  def updateTwo(inputArrayA, inputArrayB, weight, outputArray, i, j, size, ending_spot) do
    cond do
      j == size and i != ending_spot ->
        updateTwo(inputArrayA, inputArrayB, weight, outputArray, i+1, 0, size, ending_spot)

      j < size and i < ending_spot->
        partial = update(inputArrayA, weight, outputArray, i, j, size)

        hold = Stream.map([i*1024+j], fn x -> (partial+Enum.at(inputArrayB, i*size+j)) end)
        # This holds a single item that is at [i*1024+j] and holds
        # outputArrayC[i][j] + inputArrayB[i][j]

        outputArray = Stream.concat(outputArray, hold)
        # This concats the Stream that is in hold onto outputArray in the next location.
        # So, outputArray would now holds  outputArrayC[0][0]...outputArrayC[i][j-1] + outputArrayC[i][j]

        updateTwo(inputArrayA, inputArrayB, weight, outputArray, i, j+1, size, ending_spot)

      i == ending_spot ->
        outputArrayC = outputArray
    end
  end
end
