defmodule GameTest do
    use ExUnit.Case

    alias Hangman.Game

    test "init" do
        game = Game.init()

        assert game.turns_left == 7
        assert game.game_state == :initializing
        assert length(game.letters) > 0

        joined_string = game.letters
        |> Enum.join()
        is_lowercase = joined_string =~ ~r([^a-z]*$)

        assert(is_lowercase)
    end

    test "state isn't changed for :won or :lost game" do
        for state <- [:won, :lost] do
            game = Game.init() |> Map.put(:game_state, state)

            assert { ^game, _ } = Game.make_move(game, "x")
        end
    end
end
