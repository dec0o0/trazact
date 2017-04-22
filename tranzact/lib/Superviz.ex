defmodule Tranz.Superviz do
	use Supervisor

	def start_link do
		Supervisor.start_link(__MODULE__, :ok)
	end

	def init(:ok) do
		children = [
			worker(Tranz.CustRegsitry, [Tranz.CustRegsitry],
			supervizor(Tranz.Cust.Supervisor, []))
		]

		supervise(children, strategy: :ono_for_one)
	end
end