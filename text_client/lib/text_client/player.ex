defmodule TextClient.Player do

  alias TextClient.{State, Summary, Prompter, Mover}

  # won, lost, right guess, bad guess, already used, initializing
  def play(%State{ tally: %{ game_state: :won } }) do
    exit_with_message("You WON!!")
  end

  def play(game = %State{ tally: %{ game_state: :lost } }) do
    exit_with_message("You LOST :( Word was #{Enum.join(game.game_service.letters, "")}")
  end

  def play(game = %State{ tally: %{ game_state: :good_guesss } }) do
    continue_with_message(game,  "Good Guess! \n Used Letters: #{Enum.join(game.tally.used_letters, ", ")}")
  end

  def play(game = %State{ tally: %{ game_state: :bad_guess } }) do
    continue_with_message(game,  "Letter is not in the word \n Used Letters: #{Enum.join(game.tally.used_letters, ", ")}")
  end

  def play(game = %State{ tally: %{ game_state: :already_used } }) do
    continue_with_message(game,  "You've already used that letter \n Used Letters: #{Enum.join(game.tally.used_letters, ", ")}")
  end

  def play(game) do
    continue(game)
  end

  defp continue_with_message(game, message) do
    IO.puts(message)
    continue(game)
  end

  defp continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end
