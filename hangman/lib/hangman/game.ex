defmodule Hangman.Game do

    defstruct(
        turns_left: 7,
        game_state: :initializing,
        letters: []
    )

    def new_game do
        %Hangman.Game{
            letters: Dictionary.random_word |> String.codepoints
        }
    end

    defguard game_complete_guard(state) when state in [:won, :lost]
    def make_move(game = %{ game_state: state}, _guess) when game_complete_guard(state) do
        { game, tally(game) }
    end

    def tally(_game) do
        123
    end
end
