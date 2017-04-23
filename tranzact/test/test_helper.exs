ExUnit.start()

defmodule TestHelper do
	require HistoryBook

	def restart_book do
		if HistoryBook.getpid do
			HistoryBook.stop
		end
		HistoryBook.start_link
	end
end