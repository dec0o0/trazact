defmodule EventManager do
    @name :eventpid

    def start_link do
        {:ok, pid} = GenEvent.start_link []
        Process.register(pid, @name)
		{:ok, pid}
    end

    def getpid do
        Process.whereis(@name)
    end

    def stop do
		Process.exit(getpid(), :normal)
		Process.unregister(@name)
        GenEvent.stop(getpid())
	end

    def add_handler(handler) do
        GenEvent.add_handler(getpid(), handler, [])
    end

    def notify({:write, value}) do
        GenEvent.notify(getpid(), {:write, value})
    end

    def call(handler) do
        GenEvent.call(getpid(), handler, :messages)
    end
end