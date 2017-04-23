defmodule Tranzact.GlobalSupervizor do
	use Supervisor

	def start_link do
		Supervisor.start_link(__MODULE__, :ok)
	end

	def init(:ok) do
		children = [
			worker(Tranzact.ClientRegistry, [Tranzact.ClientRegistry]),
			worker(Tranzact.HistoryBank, []),
			supervisor(Tranzact.Client.Supervizor, [])
		]

		supervise(children, strategy: :one_for_one)
	end
end