defmodule Tranzact.GlobalSupervizor do
	use Supervisor

	def start_link do
		Supervisor.start_link(__MODULE__, :ok)
	end

	def init(:ok) do
		children = [
			worker(Tranzact.ClientRegistry, [Tranzact.ClientRegistry]),
			worker(Tranzact.HistoryAgent, [Tranzact.HistoryAgent]),
			supervisor(Tranzact.Client.Supervizor, [])
		]

		supervise(children, strategy: :ono_for_one)
	end
end