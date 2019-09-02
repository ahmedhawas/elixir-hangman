defmodule Hangman do

  alias Hangman.Game

  defdelegate new_game,               to: Game
  defdelegate tally(game),            to: Game
  defdelegate make_move(game, move),  to: Game
end
