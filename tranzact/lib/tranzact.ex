defmodule Tranzact do
  use Application
  
  def start(_type, _) do
    Tranzact.GlobalSupervizor.start_link
  end
  
end
