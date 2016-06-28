class Row
	def initialize
		@row = ["|", " ", "-", " ", "|", " ", "-", " ",
						"|", " ", "-", " ", "|", " ", "-", " ", "|"]
	end

	def column1=(x)
		@row[2] = x
	end

	def column2=(x)
		@row[6] = x
	end

	def column3=(x)
		@row[10] = x
	end

	def column4=(x)
		@row[14] = x
	end

	def view
		@row.join
	end

	def column(n)
		@row[(n*4)-2]
	end
end