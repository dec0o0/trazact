defmodule ExceptionHandler do
    
     use GenEvent

    def handle_event({:write, x}, messages) do
        IO.puts x
        {:ok, [x | messages]}
    end

    def handle_call(:messages, messages) do
        {:ok, Enum.reverse(messages), []}
    end

end