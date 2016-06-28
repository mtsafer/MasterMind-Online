require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'MasterMind' 

game = MasterMind.new
guess_view = []
feedback_view = []
guesses = []

get "/" do
	if params["Guess!"] == "Submit" && !game.has_ended(guesses)
		guess1 = params["spot-1"][0]
		guess2 = params["spot-2"][0]
		guess3 = params["spot-3"][0]
		guess4 = params["spot-4"][0]
		guesses = [guess1, guess2, guess3, guess4]
		game.take_turn(guesses)
		feedback = game.feed_back
		guess_view << [ find_img(guess1), find_img(guess2),
									find_img(guess3), find_img(guess4) ]
		feedback_view << select_feedback(feedback)
	end
		message = game.has_ended(guesses) if game.has_ended(guesses)
		message ||= ""
	erb :index, locals: { game: game, message: message, guess_view: guess_view,
												guesses: guesses, feedback_view: feedback_view }
end

get "/reset" do
	game = MasterMind.new
	guess_view = []
	feedback_view = []
	guesses = []
	redirect to "/"
end

def select_feedback feedback
	result = []
	feedback.each do |f|
		case f
		when "X" then result << 'img/green_check.png'
		when "O" then result << 'img/red_check.png'
		end
	end
	result
end

def find_img letter
	case letter
	when 'r' then return 'img/red.png'
	when 'g' then return 'img/green.png'
	when 'b' then return 'img/blue.png'
	when 'y' then return 'img/yellow.png'
	when 'm' then return 'img/maroon.png'
	when 'c' then return 'img/cyan.png'
	end
end