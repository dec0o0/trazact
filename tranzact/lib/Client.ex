defmodule Client do

	def start_link do
		Agent.start_link(fn -> 0.0 end)
	end

	def deposit(client, value) do
		sumFunc = fn(oldVal) -> oldVal + value end
		sumTask = Task.async(fn -> sumFunc.(getCurrentVal(client)) end)
		send(HistoryBook.getpid(), {:deposit, self(), client, value})
		newVal = Task.await(sumTask)
		Agent.update(client, fn _ -> newVal end)
		receive do
			:ok -> IO.puts "Deposit of #{value} is successfull."
		end
	end

	def credit(client, value) do
		oldValue = getCurrentVal(client)
		cond do
			oldValue >= value -> send(HistoryBook.getpid(), {:credit, self(), client, value})
			true -> send(HistoryBook.getpid(), {:credit, self(), client, 0})	
		end
		
		Agent.update(client, fn current when current >= value -> current - value end)
		receive do
			:ok -> 
				IO.puts "Credit the account with #{value} has completed."
			:no_credit -> 
				IO.puts "No credit for the #{value}."
				:failed
		end
	end

	def balance(client) do
		getCurrentVal(client)
	end

	def get_hist(client) do
		send(HistoryBook.getpid(), {:hist, self(), client})
		receive do
			{:ok, hist} -> hist
		end
	end

	def break(client) do
		send(HistoryBook.getpid(), {:translate, self(), client})
	end

	def stop(client) do
		Agent.stop(client)
	end

	defp getCurrentVal(client) do
		Agent.get(client, fn val -> val end)
	end

end