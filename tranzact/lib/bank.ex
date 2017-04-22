defmodule Bank do

	use GenServer

	@opaque accoud :: pid

	def open_bank do
		{:ok, account} = GenServer.start_link(__MODULE, 0)
		account
	end

	def close_bank do
		GenServer.stop account, :normal
	end

	def balance(account) do
		GenServer.call account, :balance
	end

	def update(account, amount) do
		GenServer.call account, {:update, amount}
	end

	def handle_call(:balance, _from, balance) do
		{:reply, balance, balance}
	end

	def handle_call({:update, amount}, _from, balance) do
		{:reply, balance, balance + amount}
	end

end