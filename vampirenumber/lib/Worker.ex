defmodule Worker do
  use GenServer

  def start_link(start_range , end_range) do
#    IO.puts "GenServer is Starting"
    {:ok, pid} = GenServer.start_link(__MODULE__,[start_range, end_range])
    GenServer.cast(pid, {:push, start_range, end_range})
   {:ok,pid}
  end

  def init(state) do
#    IO.puts "Initialize GenServer Called"
    {:ok , state}
  end

  def handle_cast({:push, start_range , end_range } , state) do
#    IO.puts "WORLD"
 # IO.puts "Hello #{start_range}  #{end_range}"
      # Enum.each( start_range..end_range , fn(x) -> checkVampireNumber( x ) end )
     # :timer.sleep(2000)
#
     # IO.puts("jek")
#
# task = for x <- start_range..end_range do Task.async( Worker, :checkVampireNumber, x) end
#
# Enum.map(task, &Task.await/1)
# #   task=  start_range..end_range |>
# # Enum.map(fn(x)  -> Task.async(Worker, :checkVampireNumber,  x ) end)
# # Enum.map(task, &Task.await/1)
# IO.puts "hello #{start_range} #{end_range}"
#
# tasks =
#       for x <- start_range..end_range do Task.async(fn -> checkVampireNumber(x)
#        end)
#       end
#     Enum.map(tasks, &Task.await/1)

    start_range..end_range |>
    Enum.map(fn(x) -> Task.async(fn  -> checkVampireNumber(x) end) end) |>
    Enum.map(fn task -> Task.await(task) end)
# IO.puts("jek")
    {:noreply , state}
  end

  def checkVampireNumber(x) do
#    IEx.Info.info(x)
   # IO.puts "Hello #{x}"
   # IO.puts("hello #{x}")

    if rem( length(Integer.digits(x)) , 2) == 1  do
      []
      # IO.puts "Hello #{x}"
    else
      list = Integer.digits(x)
      sortedList = Enum.sort(list)
      len = length(list)
      i=2
      j = trunc(:math.sqrt(x))
      # Enum.each( i..j , fn(k) -> if( rem( x, k ) == 0 and length(Integer.digits(k)) == div(len,2)
      # and length(Integer.digits( div(x,k) )) == div(len,2) and not( rem(k,10) == 0 and rem(div(x,k) ,10) == 0 )
      # and (sortedList == Enum.sort( Integer.digits(k) ++ Integer.digits(div(x,k))) ), do:
      #  IO.puts("#{x} #{k} #{div(x, k)}")
      # ) end)

      result = Enum.filter( i..j , fn(k) -> rem( x, k ) == 0 and length(Integer.digits(k)) == div(len,2)
      and length(Integer.digits( div(x,k) )) == div(len,2) and not( rem(k,10) == 0 and rem(div(x,k) ,10) == 0 )
      and (sortedList == Enum.sort( Integer.digits(k) ++ Integer.digits(div(x,k)))) end)
      # IO.inspect result

      # final_result = [x]
      # final_result = [x]
      # Enum.each( result , fn(k) -> final_result = final_result ++ [k] ++ [div(x,k)] end )
      # IO.write "#{x} "

      # result_final = for x <- 1..
      if not(Enum.empty?(result)) do
      result = [x] ++  Enum.map( result , fn (k) ->  "#{k} #{div(x,k)}" end ) |> Enum.join(" ")
      IO.puts( result )
      end
      # final_result =
      #       for k <- 1..length(result) do final_result ++ [Enum.at(result,k)] ++ [div(x,k)]
      #        end

      # final_result =
      #       for k <- 1..length(result) do List.insert_at(result , k , div(x,Enum.at(result,k-1)))
      #        end

      # IO.inspect final_result
      # Enum.each( result , fn(k) -> do final_result = final_result ++ [k] ++ [div(x,k)] end end )


      # IO.inspect(final_result)
        # [ x | result ]
        # IO.inspect final_result
       # IO.puts( Enum.join( final_result, " ") )


    end
  end


end
