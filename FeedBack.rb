class FeedBack
	def initialize
		@feed_back = ["|", "-", "|", "-", "|", "-", "|",  "-", "|"]
	end

	def column1=(x)
		@feed_back[1] = x
	end

	def column2=(x)
		@feed_back[3] = x
	end

	def column3=(x)
		@feed_back[5] = x
	end

	def column4=(x)
		@feed_back[7] = x
	end

	def view
		@feed_back.join
	end

	def column(n)
		@feed_back[(n*2)-1]
	end
end