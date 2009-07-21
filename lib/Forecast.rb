require File.dirname(File.expand_path(__FILE__)) + '/current'
require File.dirname(File.expand_path(__FILE__)) + '/day'
require File.dirname(File.expand_path(__FILE__)) + '/night'

require "Time"

module Weather

	class Forecast
		attr_reader :doc

		def initialize(doc)
	    	@doc = doc
	  	end

	  	# Current conditions
	  	def current
	    	Weather::Current.new(doc.at("weather/cc"))
	  	end

	  	# Location name
	  	def location_name
	    	doc.at("weather/loc/dnam").innerHTML
	  	end

	  	# Location ID
	  	def location_id
	    	doc.at("weather/loc")["id"]
	  	end

	  	# Unit of temperature (F | C)
	  	def temp_unit
	    	doc.at("weather/head/ut").innerHTML
	  	end

		# Unit of distance
	  	def distance_unit
	    	doc.at("weather/head/ud").innerHTML
	  	end

		# Unit of speed  	
	  	def speed_unit
	    	doc.at("weather/head/us").innerHTML
	  	end

		# Unit of precipitation
	  	def precipitation_unit
	    	doc.at("weather/head/up").innerHTML
	  	end

		# Unit of presure
	  	def presure_unit
	    	doc.at("weather/head/ur").innerHTML
	  	end  	

		# Last update (future)
	  	def last_update
	  		Time.parse(doc.at("weather/dayf/lsup").innerHTML)
	  	end

	  	# Used to know the forecast from tomorrow
	  	def tomorrow
	    	day(1)
	  	end

		# Defines a day 
	  	def day(id)
	    	day = nil
	    	(doc/"weather/dayf/day").each do |d|
	      		if d.attributes["d"] == id.to_s
	          		day = d
	      		end
	    	end
	    	Weather::Day.new(day)
		end

	  	# Defines a night
	  	def night(id)
	    	night = nil
	    	(doc/"weather/dayf/day").each do |d|
	      		if d.attributes["d"] == id.to_s
	          		night = d
	      		end
	    	end
	    	Weather::Night.new(night)
		end

	end

end