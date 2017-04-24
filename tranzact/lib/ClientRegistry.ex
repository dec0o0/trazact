defmodule ClientRegistry do
	use GenServer

	def start_link(name) do
		GenServer.start_link(__MODULE__, :ok, name: name)
	end

	def init(:ok) do
		{:ok, {%{}, %{}}}
	end

	def stop(registry) do
		GenServer.stop(registry)
	end

	def fetch(registry, client) do
		GenServer.call(registry, {:fetch, client})
	end

	def create(registry, client) do
		GenServer.cast(registry, {:create, client})
	end

	def handle_call({:fetch, client}, _from, {appPids, _} = state) do
		{:reply, Map.fetch(appPids, client), state}
	end

	def handle_cast({:create, client}, {appPids, references}) do
		if Map.has_key?(appPids, client) do
			{:noreply, {appPids, references}}
		else
			{:ok, pid} = ClientSupervizor.new_client()
			ref = Process.monitor(pid)
			{:noreply, {Map.put(appPids, client, pid), Map.put(references, ref, client)}}
		end
	end

	def handle_info({:DOWN, ref, :process, _pid, _reason}, {appPids, references}) do
		{client, references} = Map.pop(references, ref)
		{:noreply, {Map.delete(appPids, client), references}}
	end

end