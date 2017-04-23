ExUnit.start()

defmodule THelper do
	require Tranzact.HistoryBook

	def balance_restart do
		if Tranzact.HistoryBook.pid do
			Tranzact.HistoryBook.stop
		end
		Tranzact.HistoryBook.start
	end
end