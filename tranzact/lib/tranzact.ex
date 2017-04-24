defmodule Tranzact do
  use Application
  
  def start(_type, _) do
    response = GlobalSupervizor.start_link
    ClientRegistry.create(:registry, :alex)
    ClientRegistry.create(:registry, :marius)
    ClientRegistry.create(:registry, :dinu)

    EventManager.add_handler(ExceptionHandler)
    EventManager.notify({:write, "Banking tranzaction system started!"})
    response
  end
  
end
