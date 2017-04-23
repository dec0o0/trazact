defmodule Tranzact do
  use Application
  
  def start(_type, _) do
    GlobalSupervizor.start_link
  end
  
end
