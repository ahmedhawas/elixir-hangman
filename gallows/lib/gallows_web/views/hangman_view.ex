defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view
  import Gallows.Views.Helpers.GameStateHelper

  def game_over?(%{ game_state: game_state }) do
    game_state in [ :won, :lost ]
  end

  def new_game_button(conn) do
    link("New Game", to: Routes.hangman_path(conn, :create_game))
  end
end
