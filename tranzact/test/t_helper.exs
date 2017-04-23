ExUnit.start()

defmodule THelper do
	require Tranzact.HistoryBank

	def balance_restart do
		if Tranzact.HistoryBank.pid do
			Tranzact.HistoryBank.stop
		end
		Tranzact.HistoryBank.start
	end
end