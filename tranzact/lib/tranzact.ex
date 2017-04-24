defmodule Tranzact do
  use Application
  
  def start(_type, _) do
    response = GlobalSupervizor.start_link
    ClientRegistry.create(:registry, :alex)
    ClientRegistry.create(:registry, :marius)
    ClientRegistry.create(:registry, :dinu)
    response
  end
  
end
