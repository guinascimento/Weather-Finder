module Weather

	class FutureEstimate
		attr_reader :doc

		def initialize(doc)
	    	@doc = doc
	  	end

	  	# Icon
	  	def icon
	    	part.at("icon").innerHTML
	  	end

	  	# Description
	  	def description
	    	part.at("t").innerHTML
	  	end

	  	# Precipitation
	  	def precipitation
	    	part.at("ppcp").innerHTML
	  	end

	  	# Humidity
	  	def humidity
	    	part.at("hmid").innerHTML
	  	end

	  	# High temperature
	  	def high
	    	doc.at("hi").innerHTML
	  	end

	  	# Low temperature
	  	def low
	    	doc.at("low").innerHTML
	  	end

		# Sunrise
		def sunrise
	    	doc.at("sunr").innerHTML
		end

	  	# Sunset
		def sunset
	    	doc.at("suns").innerHTML
	  	end

	  	# Wind conditions
	  	def wind
	    	Weather::Wind.new(part.at("wind"))
	  	end

	end

end	