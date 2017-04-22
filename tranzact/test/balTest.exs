defmodule BalanceTest do

	use ExUnit.Case
	require TestHelper

	test "start to finish" do
		Balance.start
		assert Process.isAlive?(Balance.pid)
		Balance.stop
		assert Balance.pid == nil
	end

	test "balance init" do
		TestHelper.balance_restart
		assert Customer.read_balance == 0.0
		Balance.stop
	end
end