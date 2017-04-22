defmodule Tranz.Cust.Superviz do
	use Supervisor

	@name Tranz.Cust.Superviz

	def start_link do
		Supervisor.start_link(__MODULE, :ok, name :@name)
	end

	def start_cust do
		Supervisor.start_child(@name, [])
	end

	def init(:ok) do
		children = [
			worker(Tranz.Customer, [], restart: :temporary)
		]

		supervise(children, strategy: :simple_one_for_one)
	end
end