
module Instructions

    def write_instructions
        <<-HEREDOC
        Welcome to hangman!
        A random word will be generated.  You will be asked to guess the characters of this word.
        If you guess incorrectly 6 times you will lose!

        You can save at any time and exit the game by typing "save" instead of a letter.  

        LET'S BEGIN!
        
        Type "play" to begin a new game.  Type "load" to load the previous save file.
        
        HEREDOC
    end


end