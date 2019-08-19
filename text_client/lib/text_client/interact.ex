defmodule TextClient.Interact do

  alias TextClient.State
  def start() do
    Hangman.new_game()
    |> setup_state()
    |> IO.inspect
  end

  def play(state) do
  end

  defp setup_state(game) do
    %State{
      game_service: game,
      tally: Hangman.tally(game)
    }
  end
end