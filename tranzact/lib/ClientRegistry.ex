defmodule Tranzact.ClientRegistry do

	def start_link(name) do
		GenServer.start_link(__MODULE__, :ok, name: name)
	end

	def stop(registry) do
		GenServer.stop(registry)
	end

	def fetch(registry, cust) do
		GenServer.call(registry, {:fetch, cust})
	end

	def create(registry, cust) do
		GenServer.cast(registry, {:create, cust})
	end

	def init(:ok) do
		{:ok, {%{}, %{}}}
	end

	def handle_call({:fetch, cust}, _from, {all, _} = state) do
		{:reply, Map.fetch(all, cust), state}
	end

	def handle_cast({:create, cust}, {all, references}) do
		if Map.has_key?(all, cust) do
			{:noreply, {all, references}}
		else
			{:ok, pid} = Tranzact.Client.Supervizor.new_client()
			ref = Process.monitor(pid)
			{:noreply, {Map.put(all, cust, pid), Map.put(references, ref, cust)}}
		end
	end

	def handle_info({:DOWN, ref, :process, _pid, _reason}, {all, references}) do
		{cust, references} = Map.pop(references, ref)
		{:noreply, {Map.delete(all, cust), references}}
	end

end