ExUnit.start()

defmodule THelper do
	require Tranzact.HistoryAgent

	def balance_restart do
		if Tranzact.HistoryAgent.pid do
			Tranzact.HistoryAgent.stop
		end
		Tranzact.HistoryAgent.start
	end
end