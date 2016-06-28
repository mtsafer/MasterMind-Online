require_relative './Row'

# Available colors: Red Green Yellow Blue Magenta Cyan

class MasterMind

	attr_reader :remembered_turns, :secret, :feed_back

	def initialize
		#@secret = hashify(colorize(generate_secret))
		@secret = hashify generate_secret
		@turn = 0
		@rows = []
		@feed_backs = []
		@feed_back = []
		for i in 1..12
			@rows << Row.new
			@feed_backs << []
		end
		@border = "--------------------------------"
		@remembered_turns = []
	end

	def turns_left
		return (12-@turn)
	end

	def has_ended(guesses)
		ended = false
		ended = true if @turn >= 12
		ended = check_feedback(guesses) unless ended
		ended = end_state if ended
		ended
	end

	def end_state
		return "You won!" if @turn < 12
		return "You lose!" if @turn >= 12
	end

	def check_feedback(guesses)
		@feed_back == ["X","X","X","X"]
	end

	def take_turn(guesses)
		@remembered_turns << guesses
		@feed_backs[@turn] = set_feedback(guesses)
		@turn += 1
	end

	def set_feedback(guesses)
		feed_back_helper = []
		guesses.each_with_index do |guess, index|
			if guess == @secret[index][:guess]
				feed_back_helper << "X"
				@secret[index][:looked] = true
				guesses[index] = " "
			end
		end
		guesses.each_with_index do |guess, index|
			@secret.each do |x|
				unless x[:looked]
					if x[:guess] == guess
						feed_back_helper << "O"
						x[:looked] = true
						guess = " "
						guesses[index] = " "
					end
				end
			end
		end
		@secret.each{ |x| x[:looked] = false }
		@feed_back = feed_back_helper
		return feed_back_helper
	end

	private

		def hashify(guesses)
			guess_array_hash = []
			guesses.each do |guess|
				guess_array_hash << {guess: guess, looked: false}
			end 
			guess_array_hash
		end

		def generate_secret
			colors = ["r","g","b","y","c","m"]
			secret = []
			4.times{ secret << colors[rand(colors.length)] }
			secret
		end
end