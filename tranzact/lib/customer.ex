defmodule Customer do

	# Simple process

	def deposit(value) do
		send(Balance.pid, {:credit, self(), value})
		receive do
			:ok -> IO.puts "deposit of #{value} is successfull"
		end
	end

	def withdrawal(value) do
		send(Balance.pid, {:debit, self(), value})
		receive do
			:ok -> IO.puts "here s your money: #{value}"
			:no_balance -> 
				IO.puts "Not enough money"
				:failed
		end
	end

	def read_balance do
		send(Balance.pid, {:read, self()})
		receive do
			{:ok, balance} -> IO.puts "Your balance is #{balance}"
			balance
		end
	end

end