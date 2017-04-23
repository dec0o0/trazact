defmodule Tranzact.HistoryBook do
	@name :history

	def start_link do
		pid = Kernel.spawn_link(fn -> loop(%{}) end)
		Process.register(pid, @name)
		{:ok, pid}
	end

	def pid, do: Process.whereis(@name)

	def stop do
		Process.exit(pid(), :normal)
		Process.unregister(@name)
	end

	defp loop(map) do
		receive do

			{:credit, client_pid, key, val} when val > 0 -> 
				send(client_pid, :ok)
				oldList = Map.get(map, key, [])
				loop(Map.put(map, key, [val | oldList]))

			{:deposit, client_pid, key, val} when val > 0 ->
				send(client_pid, :ok)
				oldList = Map.get(map, key, [])
				loop(Map.put(map, key, [val * -1 | oldList]))

			{:credit, client_pid, _, _} ->
				send(client_pid, :no_hist)
				loop(map)

			{:hist, client_pid, key} -> 
				send(client_pid, {:ok, Map.get(map, key, [])})
				loop(map)

			{_, _, _} ->
				raise "Unsupported operation"
		end
	end

end