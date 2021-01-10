
require_relative 'game.rb'
require_relative 'instructions.rb'
include Instructions
puts write_instructions
game = Game.new

#begins game with blank board.
game.make_game_board

#sets turn one values
guess_letter = ""

loop{
puts "Would you like to play or load?"
play_load = gets.chomp
if play_load == "play"
    game.read_word_file
    game.choose_word.downcase
    game.make_word_array
    break
elsif play_load == "load"
    if File.exists? ("save/save_file.dump")
        puts "Game loaded\n"
        game = YAML.load(File.read("save/save_file.dump"))
        break
    else
        puts "Saved file not found"
        exit
    end
else
    puts "That is an invalid option.  Please type 'play' or 'load'"
end
}





#begins to iterate through turns.  

loop{
game.check_for_loss
guess_letter = game.turn
    if guess_letter == "save"
        Dir.mkdir("save") unless Dir.exists?("save")
 
        File.open("save/save_file.dump", 'w') { |f| f.write(YAML.dump(game))}
        exit
    end
game.check_letter(guess_letter)
game.build_current_board
game.check_for_win
}