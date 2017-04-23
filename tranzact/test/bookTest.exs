defmodule BookTest do

	use ExUnit.Case
	require TestHelper

	test "start to finish" do
		HistoryBook.start_link
		assert Process.isAlive?(HistoryBook.getpid)
		HistoryBook.stop
		assert HistoryBook.getpid == nil
	end

	test "balance init" do
		TestHelper.restart_book
		assert Process.isAlive?(HistoryBook.getpid)
		send(HistoryBook.getpid(), {:aiurea, 1, 1})
		assert HistoryBook.getpid == nil
	end
	
end