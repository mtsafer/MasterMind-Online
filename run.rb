require 'sinatra'
require 'sinatra/reloader' if development?
require_relative './MasterMind' 

use Rack::Session::Pool, :expire_after => 2592000

#game = MasterMind.new
#guess_view = []
#feedback_view = []
#guesses = []

get "/" do
	session[:game] = MasterMind.new
	session[:guess_view] = []
	session[:feedback_view] = []
	session[:message] = ""
	redirect to "/play"
end

get "/play" do
	if params["Guess!"] == "Submit"
		guess1 = params["spot-1"][0]
		guess2 = params["spot-2"][0]
		guess3 = params["spot-3"][0]
		guess4 = params["spot-4"][0]
		guesses = [guess1, guess2, guess3, guess4]
		unless session[:game].has_ended(guesses)
			session[:game].take_turn(guesses)
			feedback = session[:game].feed_back
			session[:guess_view] << [ find_img(guess1), find_img(guess2),
										find_img(guess3), find_img(guess4) ]
			session[:feedback_view] << select_feedback(feedback)
		end
	end
	session[:message] = session[:game].has_ended(guesses) if \
	session[:game].has_ended(guesses)
	erb :index, locals: { game: session[:game], message: session[:message],
												guess_view: session[:guess_view],
												guesses: guesses,
												feedback_view: session[:feedback_view] }
end

private
	def select_feedback feedback
		result = []
		feedback.each do |f|
			case f
			when "X" then result << 'green_check.png'
			when "O" then result << 'red_check.png'
			end
		end
		result
	end

	def find_img letter
		case letter
		when 'r' then return 'red.png'
		when 'g' then return 'green.png'
		when 'b' then return 'blue.png'
		when 'y' then return 'yellow.png'
		when 'm' then return 'maroon.png'
		when 'c' then return 'cyan.png'
		end
	end