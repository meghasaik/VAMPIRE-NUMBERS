defmodule Boss do
  use Supervisor

  def start_link(n1 , n2) do
    Supervisor.start_link(__MODULE__,[n1,n2])
  end

  def init( input \\ [] ) do
    [ n1 , n2 ] = Enum.map( input , fn x -> (x) end )
    actors = 500
    len = div( (n2 - n1) , actors)
    invokecheckVampire( actors, len , n1 , n2 )
   end

  def invokecheckVampire( actors , len , n1 , n2 ) when (n2-n1) > len do
    probs = Enum.map( 1..actors , fn(x) ->
      worker(Worker, [ n1 + 1 + ((x-1) * len) , n1 + (x * len) ] ,[id: x])
    end)
    supervise(probs , strategy: :one_for_one)
  end

  def invokecheckVampire( _actors , len , n1 , n2 ) when (n2-n1) <= len do
    IO.puts "World"
    probs = Enum.map( 1..1 , fn(_x) ->
      worker(Worker, [ n1 , n2 ] )
    end)
    supervise(probs , strategy: :one_for_one)
  end
end
