require_relative './Row'
require_relative './FeedBack'
require 'colorize'

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
			@feed_backs << FeedBack.new
		end
		@border = "--------------------------------"
		@remembered_turns = []
	end

	def look
		result = ""
		result += "\n"
		result += "(Feedback)--->     (Guess)\n"
		result += @border + "\n"
		result += "#{@feed_backs[0].view} ---> #{@rows[0].view}\n"
		result += @border + "\n"
		for i in 1...@turn
			result += "#{@feed_backs[i].view} ---> #{@rows[i].view}\n"
			result += @border + "\n"
		end
		result
	end

	def turns_left
		return (12-@turn)
	end

	def peek
		@secret.each{ |x| print x[:guess] }
		puts ""
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
		#guesses = colorize(guesses)
		row = @rows[@turn]
		row.column1 = guesses[0]
		row.column2 = guesses[1]
		row.column3 = guesses[2]
		row.column4 = guesses[3]
		@feed_backs[@turn] = set_feedback(guesses)
		@turn += 1
	end

	def set_feedback(guesses)
		feed_back = @feed_backs[@turn]
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
		#feed_back_helper << ["-","-","-","-"]
		#feed_back = assign_feedback(feed_back, feed_back_helper.flatten)
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

		def assign_feedback(feed_back, feed_back_helper)
			feed_back.column1 = (feed_back_helper[0])
			feed_back.column2 = (feed_back_helper[1])
			feed_back.column3 = (feed_back_helper[2])
			feed_back.column4 = (feed_back_helper[3])
			feed_back
		end

		def colorize(guesses)
			for i in 0..3
				case guesses[i]
				when 'r' then guesses[i] = "X".red
				when 'g' then guesses[i] = "X".green
				when 'b' then guesses[i] = "X".blue
				when 'y' then guesses[i] = "X".yellow
				when 'm' then guesses[i] = "X".magenta
				when 'c' then guesses[i] = "X".cyan
				else
					puts "The guesses are corrupt"
				end
			end
			guesses
		end
end