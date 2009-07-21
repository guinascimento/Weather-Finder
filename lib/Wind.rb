module Weather

	class Wind
		attr_reader :doc

		def initialize(doc)
			@doc = doc
		end

		# Wind speed
		def speed
			doc.at("s").innerHTML
		end

		# Wind gust speed
		def gust_speed
			doc.at("gust").innerHTML
		end

		# Wind direction
		def direction
			doc.at("d").innerHTML
		end

		# Wind description
		def description
			doc.at("t").innerHTML
		end

	end

end	