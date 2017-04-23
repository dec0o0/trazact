defmodule Tranzact.ExceptionHandler do
    
     use GenEvent

    # Callbacks

    def handle_event({:log, x}, messages) do
        {:ok, [x | messages]}
    end

    def handle_call(:messages, messages) do
        {:ok, Enum.reverse(messages), []}
    end

end