defmodule EventManager do
    @name :eventpid

    def start_link do
        {:ok, pid} = GenEvent.start_link [{:name, __MODULE__}]
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

    def notify({:log, value}) do
        GenEvent.notify(getpid(), {:log, value})
    end

    def call(handler) do
        GenEvent.call(getpid(), handler, :messages)
    end
end