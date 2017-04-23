defmodule GlobalSupervizor do
	use Supervisor

	def start_link do
		Supervisor.start_link(__MODULE__, :ok)
	end

	def init(:ok) do
		children = [
			worker(ClientRegistry, [ClientRegistry]),
			worker(HistoryBook, []),
			# worker(EventManager, []),
			supervisor(Client.Supervizor, [])
		]

		supervise(children, strategy: :one_for_one)
	end
end