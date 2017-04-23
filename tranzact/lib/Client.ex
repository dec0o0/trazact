defmodule Tranzact.Client do

	def start_link do
		Agent.start_link(fn -> 0.0 end)
	end

	def deposit(client, value) do
		sumTask = doOperationForCustomer(client, &(&1 + value))
		send(Tranzact.HistoryBank.pid, {:deposit, self(), client, value})
		Agent.update(client, fn(_) -> sumTask.await() end)
		receive do
			:ok -> IO.puts "Deposit of #{value} is successfull."
		end
	end

	def credit(client, value) do
		substractTask = doOperationForCustomer(client, &(&1 - value))
		send(Tranzact.HistoryBank.pid, {:credit, self(), client, value})
		Agent.update(client, fn(_) -> substractTask.await() end)
		receive do
			:ok -> IO.puts "Credit the account with #{value} has completed."
			:no_hist -> 
				IO.puts "New account, no."
				:failed
		end
	end

	def balance(client) do
		getCurrentVal(client)
	end

	def get_hist(client) do
		send(Tranzact.HistoryBank.pid, {:hist, self(), client})
		receive do
			{:ok, hist} -> hist
		end
	end

	def break(client) do
		send(Tranzact.HistoryBank.pid, {:translate, self(), client})
	end

	def stop(client) do
		Agent.stop(client)
	end

	defp getCurrentVal(client) do
		Agent.get(client, fn val -> val end)
	end

	defp doOperationForCustomer(client, func) do
		Task.async(fn -> func.(getCurrentVal(client)) end)
	end

end