defmodule ClientTest do

	use ExUnit.Case, async: false
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

	test "balance test" do
		{:ok, client} = Tranzact.Client.start_link
		assert Tranzact.Client.balance(client) == 0.0
  	end

	test "deposit test" do
		{:ok, client} = Tranzact.Client.start_link
		
		Tranzact.Client.deposit(client, 235.90)
		assert Tranzact.Client.balance(client) == 235.90

		Tranzact.Client.deposit(client, 235.90)
		assert Tranzact.Client.balance(client) == 235.90 * 2
  	end 
	  
	test "stop client" do
		{:ok, client} = Tranzact.Client.start_link
		assert :ok == Tranzact.Client.stop(client)
	end

	test "credit test" do
		{:ok, client} = Tranzact.Client.start_link
		
		Tranzact.Client.deposit(client, 235.90)

		Tranzact.Client.credit(client, 235.90)
		assert Tranzact.Client.balance(client) == 0.0
	end
	
	# test "balance test" do
	# 	{:ok, client} = Tranzact.Client.start_link
	# 	assert Tranzact.Client.balance(client) == 0.0

	# 	Tranzact.Client.deposit(client, 235.90)
	# 	assert Tranzact.Client.balance(client) == 235.90
  	# end

end