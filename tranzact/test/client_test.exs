defmodule ClientTest do

	use ExUnit.Case, async: false
	
	test "balance initial test" do
		{:ok, client} = Client.start_link
		assert Client.balance(client) == 0.0
  	end

	test "deposit test" do
		{:ok, client} = Client.start_link
		
		Client.deposit(client, 235.90)
		assert Client.balance(client) == 235.90

		Client.deposit(client, 235.90)
		assert Client.balance(client) == 235.90 * 2
  	end 
	  
	test "stop client" do
		{:ok, client} = Client.start_link
		assert :ok == Client.stop(client)
	end

	test "credit test" do
		{:ok, client} = Client.start_link
		
		Client.deposit(client, 235.90)

		Client.credit(client, 235.90)
		assert Client.balance(client) == 0.0
	end

end