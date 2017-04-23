defmodule Tranzact.Client do

	def start_link do
		Agent.start_link(fn -> 0.0 end)
	end

	def deposit(client, value) do
		# sumTask = doOperationForCustomer(client, &(&1 + value))
		send(Tranzact.HistoryBook.pid, {:deposit, self(), client, value})
		Agent.update(client, fn current -> current + value end)
		receive do
			:ok -> IO.puts "Deposit of #{value} is successfull."
		end
	end

	def credit(client, value) do
		# substractTask = doOperationForCustomer(client, &(&1 - value))
		oldValue = getCurrentVal(client)
		cond do
			oldValue >= value -> send(Tranzact.HistoryBook.pid, {:credit, self(), client, value})
			true -> send(Tranzact.HistoryBook.pid, {:credit, self(), client, 0})	
		end
		
		Agent.update(client, fn current when current >= 0 -> current - value end)
		receive do
			:ok -> IO.puts "Credit the account with #{value} has completed."
			:no_hist -> 
				IO.puts "New account, no."
				:failed
			:no_credit -> "No credit for the #{value}."
		end
	end

	def balance(client) do
		getCurrentVal(client)
	end

	def get_hist(client) do
		send(Tranzact.HistoryBook.pid, {:hist, self(), client})
		receive do
			{:ok, hist} -> hist
		end
	end

	def break(client) do
		send(Tranzact.HistoryBook.pid, {:translate, self(), client})
	end

	def stop(client) do
		Agent.stop(client)
	end

	defp getCurrentVal(client) do
		Agent.get(client, fn val -> val end)
	end

	# defp doOperationForCustomer(client, func) do
	# 	Task.async(fn -> func.(getCurrentVal(client)) end)
	# end

end