defmodule Tranzact do
  use Application
  
  def start(_type, args) do
    Tranz.Superviz.start_link
  end

  
end
