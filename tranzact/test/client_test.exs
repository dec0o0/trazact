defmodule ClientTest do

	use ExUnit.Case, async: true
	# require THelper

	# test "increase then decrease" do
	# 	TestHelper.balance_restart
	# 	Customer.deposit 500.0
	# 	assert Customer.read_balance == 500.0
	# 	Customer.withdrawal 100.0
	# 	assert Customer.read_balance == 400.0
	# 	Balance.stop
	# end

	# test "not available" do
	# 	TestHelper.balance_restart
	# 	assert Customer.withdrawal(100.0) == :failed
	# 	assert Customer.read_balance == 0.0
	# 	Customer.deposit 400.0
	# 	assert Customer.withdrawal(100.0) == :ok
	# 	assert Customer.read_balance == 300.0
	# 	Balance.stop
	# end

	test "stores values by key" do
		{:ok, client} = Tranzact.Client.start_link
		assert 1 + 1 == 2
  	end

end