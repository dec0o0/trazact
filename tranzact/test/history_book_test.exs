defmodule Tranzact.HistoryBookTest do
	use ExUnit.Case, async: false

    import HistoryBook

    test "valid pid" do
        if HistoryBook.getpid != nil do
			HistoryBook.stop
		end

        {:ok , pid} = HistoryBook.start_link

        assert pid == HistoryBook.getpid
    end

    test "insert deposit" do
        if HistoryBook.getpid != nil do
			HistoryBook.stop
		end

        HistoryBook.start_link

        # create a agent
        {:ok, agentPid } = Agent.start_link(fn -> 0.0 end)
        send HistoryBook.getpid, {:deposit, self(), agentPid, 23}

        receive do
            :ok -> assert true
            _ -> assert false
        end
        
    end

    #  test "no hist" do
    #     if HistoryBook.getpid != nil do
	# 		HistoryBook.stop
	# 	end

    #     HistoryBook.start_link

    #     # create a agent
    #     {:ok, agentPid } = Agent.start_link(fn -> 0.0 end)
    #     send HistoryBook.getpid, {:deposit, self(), :no_matter, :no_matter_1}

    #     receive do
    #         :no_hist -> assert true
    #         _ -> assert false
    #     end
        
    # end

end