
require './instructions'
require "yaml"

class Game
    include Instructions
    def initialize
        @guess_number = 0
        @correct_index_list = []
        @text_file = []
        @word = ""
        @word_array = []
        @underscore_array = []
        @state_of_board = []
        @number_incorrect = 0
    end

    

    def save_or_load
        name = gets.chomp
        return name.to_s
    end

    #Function reads word text file and turns it into an array of words.

    def read_word_file
        File.open("5desk.txt").each { |line| @text_file << line }
    end

    #Function reads list of words and chooses one of the appropriate length.
    def choose_word
        word_index = 0
        loop{
            word_index = rand(@text_file.length.to_i)
            if @text_file[word_index].length.to_i > 4  && @text_file[word_index].length.to_i < 12
            break
            end
        }
        @word = @text_file[word_index]
    end

    #Function splits word into an array of letters.
    def make_word_array
        @word_array = @word.chars.to_a
    end

    #Function creates underscore array.
    def make_game_board
        i = 0
        while i < @word.length - 2
            @underscore_array << "_"
            i += 1
        end
        @state_of_board = @underscore_array
    end



    #takes user input.  Checks if string.
    def turn
        puts "You have #{@number_incorrect} incorrect guesses out of 6 possible."  
        puts "The current state of the board is:" 
        i = 0
        guess_letter = ""
        while i < @state_of_board.length
            print @state_of_board[i] + " "
            i += 1
        end

        puts " "
        puts "What is your next guess?"
        loop{
            guess_letter = gets.chomp
            
            if guess_letter == "save"
                break
            elsif guess_letter.length == 1 && guess_letter.match?(/[[:alpha:]]/)
                break
            else 
                puts "Incorrect input.  Try again."
            end
        }
        #guess_letter = guess_letter.to_s.downcase
        return guess_letter.downcase
    end


    #checks if letter is correct and adds to correct_index_list
    def check_letter(guess_letter)
        @word_array.each_with_index { |letter, index|
            if letter == guess_letter
                @correct_index_list.append(index)
            end
        }
        if @word_array.include? guess_letter
            puts "Congratulations you guess a letter correctly!"
        else
            puts "Sorry!  You did not guess a correct letter."
            @number_incorrect += 1
        end
        return @correct_index_list
    end


    #builds the state of board after checking if guess is correct
    def build_current_board
        i = 0
        @state_of_board = []
        while i < @word_array.length.to_i - 2
            
            if @correct_index_list.include?(i)
                @state_of_board[i] = @word_array[i]
            else
                @state_of_board[i] = "_"
            end
            i += 1
        end 
        return @state_of_board
    end

    #checks if game is won.
    def check_for_win
        i = 0
        @state_of_board.each{ |letter|
            if letter == "_"
                i += 1
            else
                next
            end
        }
        if i == 0
            puts "Congratulations!  You have guessed the final letter!"

            puts "The word is:"
            k = 0
            while k < @state_of_board.length
                print @state_of_board[k] + " "
                k += 1
            end

            puts "Please play again!"
            exit
        end
    end

    #checks if game is lost.  
    def check_for_loss
        if @number_incorrect.to_i == 6
            puts "Unfortuntately you are out of guesses.  Please play again!"
            exit
        end
    end


end