defmodule ClientSupervizor do
	use Supervisor

	@name ClientSupervizor

	def start_link do
		Supervisor.start_link(__MODULE__, :ok, name: @name)
	end

	def new_client do
		Supervisor.start_child(@name, [])
	end

	def init(:ok) do
		children = [
			worker(Client, [], restart: :temporary)
		]

		supervise(children, strategy: :simple_one_for_one)
	end
end