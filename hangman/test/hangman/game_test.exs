defmodule GameTest do
    use ExUnit.Case

    alias Hangman.Game

    test "new_game" do
        game = Game.new_game()

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
            game = Game.new_game() |> Map.put(:game_state, state)

            assert ^game = Game.make_move(game, "x")
        end
    end

    # test "should return error if multiple letters are guessed at a time" do
    #     game = Game.new_game()
    #     game = Game.make_move(game, "ab")
    #     assert game.state == :bad_input
    # end

    test "first occurrence of letter is not already used" do
        game = Game.new_game()
        game = Game.make_move(game, "x")
        assert game.game_state != :already_used
    end

    test "second occurrence of letter is already used" do
        game = Game.new_game()
        game = Game.make_move(game, "x")
        assert game.game_state != :already_used

        game = Game.make_move(game, "x")
        assert game.game_state == :already_used
    end

    test "a good guess is recognized" do
        game = Game.new_game("wibble")
        game = Game.make_move(game, "w")

        assert game.game_state == :good_guess
        assert game.turns_left == 7
    end

    test "a good guess wins the game" do
        moves = [
            {"w", :good_guess},
            {"i", :good_guess},
            {"b", :good_guess},
            {"l", :good_guess},
            {"e", :won}
        ]

        game = Game.new_game("wibble")

        Enum.reduce(moves, game, fn ({ guess, state}, game_memo) ->
            game_memo = Game.make_move(game_memo, guess)
            assert game_memo.game_state == state
            game_memo
        end)
    end

    test "a bad guess is recognized" do
        game = Game.new_game("wibble")
        game = Game.make_move(game, "x")
        assert game.game_state == :bad_guess
        assert game.turns_left == 6
    end

    test "a bad guess is recognized and lost game" do
        game = Game.new_game("wibble")

        game = Game.make_move(game, "x")
        assert game.game_state == :bad_guess
        assert game.turns_left == 6

        game = Game.make_move(game, "q")
        assert game.game_state == :bad_guess
        assert game.turns_left == 5

        game = Game.make_move(game, "k")
        assert game.game_state == :bad_guess
        assert game.turns_left == 4

        game = Game.make_move(game, "a")
        assert game.game_state == :bad_guess
        assert game.turns_left == 3

        game = Game.make_move(game, "c")
        assert game.game_state == :bad_guess
        assert game.turns_left == 2

        game = Game.make_move(game, "d")
        assert game.game_state == :bad_guess
        assert game.turns_left == 1

        game = Game.make_move(game, "z")
        assert game.game_state == :lost
    end
end
