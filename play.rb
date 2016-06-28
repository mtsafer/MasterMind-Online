require_relative './MasterMind'

def play

	game = MasterMind.new

#	puts "Follow the prompts to play"
#	puts "Enter 'Red' 'Green' 'Blue' 'Yellow' 'Magenta' 'Cyan'"
#	puts "or their first letter"
#	puts ""
#	game.look
#	until game.has_ended
#		guess1 = guess(1)
#		guess2 = guess(2)
#		guess3 = guess(3)
#		guess4 = guess(4)
#		game.take_turn([guess1, guess2, guess3, guess4])
#		game.look
#	end
end

private
	def guess(x)
		valid = ["r", "g", "b", "y", "m", "c"]
		print "Column #{x} (rgbymc): "
		guess = gets.chomp[0]
		guess = guess(x) if guess.nil?
		unless valid.include? guess.downcase
			puts "Invalid response! \n"
			guess = guess(x)			
		end
		guess
	end

play