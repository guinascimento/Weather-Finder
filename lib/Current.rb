require File.dirname(File.expand_path(__FILE__)) + '/wind'

require "Time"

module Weather

	class Current
		attr_reader :doc

		def initialize(doc)
	    	@doc = doc
	 	end

	  	# Icon to be displayed
	  	def icon
	    	doc.at("icon").innerHTML
	  	end

	  	# Outlook message
	  	def description
	    	doc.at("t").innerHTML
	  	end

	  	# Forecast date
	  	def date
	    	Time.now
	  	end

	  	# Temperature
	  	def temp
	    	doc.at("tmp").innerHTML
	  	end

		# Last update (current)
		def last_update
			Time.parse(doc.at("lsup").innerHTML)
		end

	  	# Wind conditions
	  	def wind
	    	Weather::Wind.new(doc.at("wind"))
	  	end

	end

end