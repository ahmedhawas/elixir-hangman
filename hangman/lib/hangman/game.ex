defmodule Hangman.Game do

    defstruct(
        turns_left: 7,
        game_state: :initializing,
        letters: []
    )
    
    def init do
        %Hangman.Game{
            letters: Dictionary.random_word |> String.codepoints
        }
    end
end