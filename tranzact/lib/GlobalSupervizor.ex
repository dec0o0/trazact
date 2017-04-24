defmodule GlobalSupervizor do
	use Supervisor

	@name GlobalSupervizor

	def start_link do
		Supervisor.start_link(__MODULE__, :ok, name: @name)
	end

	def init(:ok) do
		children = [
			worker(ClientRegistry, [:registry]),
			worker(HistoryBook, []),
			supervisor(ClientSupervizor, [])
		]

		supervise(children, strategy: :one_for_one)
	end
end