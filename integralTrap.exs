defmodule TrapIntegral do
    def main(numberProcesses) do
        starttime = DateTime.utc_now()
        IO.puts Task.async_stream(1..numberProcesses, TrapIntegral, :trapezoidFun, [numberProcesses], timeout: 1000000) |> Enum.map(fn{:ok, result} -> result end) |> Enum.sum()
        endtime = DateTime.utc_now()

        IO.puts "#{DateTime.diff(endtime, starttime, :microsecond)} microseconds"
    end

    def trapezoidFun(id, num_of_processes) do
        id = id-1

        h = (10-0)/8388600;

        multi = div(8388600, num_of_processes)
        remainder = rem(8388600, num_of_processes)
        starting_spot = id*multi
        ending_spot = if id != (num_of_processes-1), do: multi+starting_spot, else: multi+starting_spot+remainder
        output = integral(0, starting_spot, h, starting_spot, ending_spot, 0)
    end

    def integral(p_current, i, h, starting_spot, ending_spot, summ) do
        cond do
            i > ending_spot ->
                sumC = summ
            i <= ending_spot ->
                currentP = i*h
                low_result = :math.cos(currentP)
                high_result = :math.cos(currentP+h)
                partial = summ + ((low_result + high_result)*h / 2.0)
                cur_spot = currentP + h
                integral(cur_spot, i+1, h, starting_spot, ending_spot, partial)
        end
    end
end