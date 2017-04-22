defmodule BalanceTask do
	@name :balance

	def start do
		{:ok, pid} = Task.start_link(fn -> loop(%{}) end)
		Process.register(pid, @name)
	end

	def pid, do: Process.whereis(@name)

	def stop do
		Process.exit(pid(), :normal)
		Process.unregister(@name)
	end

	def loop(map) do
		receive do
			{:read, cust_pid, key} -> 
				send cust_pid, {:ok, Map.get(map, key)})
				loop(map)
			{:credit, cust_pid, key, val} -> 
				send(cust_pid, :ok)
				newBal = Map.get(map, key) + val
				loop(Map.put(map, key, newBal))
			{:debit, cust_pid, key, val} when 
					!Map.has_key?(key) || (Map.get(map, key) - val) > 0 ->
				send(cust_pid, :ok)
				newBal = Map.get(map, key) + val
				loop(Map.put(map, key, newBal))
			{:debit, cust_pid, key, _} ->
				send(cust_pid, :no_balance)
				loop(map)
			{_, cust_pid, key} when !Map.has_key?(key) ->
				IO.puts "Unsupported operation"
		end
	end

end