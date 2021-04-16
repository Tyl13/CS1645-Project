defmodule Matrices do
  def mapsFun(x,) do
  	matrix_a =map_A(x)
    weight = map_A(x)
  	matrix_b =map_B(x)
    outputArray = Stream.map(0..0, fn x -> (x*0) end)
    # spawn process
    # do math to get starting and ending points for each process.
    # convert starting point into i and j spot
    output = Enum.sum(updateTwo(matrix_a, matrix_b, weight, outputArray, 0, 0, x))
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

  def updateTwo(inputArrayA, inputArrayB, weight, outputArray, i, j, size) do
    cond do
      j == size and i != size ->
        updateTwo(inputArrayA, inputArrayB, weight, outputArray, i+1, 0, size)

      j < size and i < size->
        partial = update(inputArrayA, weight, outputArray, i, j, size)

        hold = Stream.map([i*1024+j], fn x -> (partial+Enum.at(inputArrayB, i*size+j)) end)
        # This holds a single item that is at [i*1024+j] and holds
        # outputArrayC[i][j] + inputArrayB[i][j]

        outputArray = Stream.concat(outputArray, hold)
        # This concats the Stream that is in hold onto outputArray in the next location.
        # So, outputArray would now holds  outputArrayC[0][0]...outputArrayC[i][j-1] + outputArrayC[i][j]

        updateTwo(inputArrayA, inputArrayB, weight, outputArray, i, j+1, size)

      i == size ->
        outputArrayC = outputArray
    end
  end
end

defmodule  TaskManager do
  def sync do
    task
  end
end
