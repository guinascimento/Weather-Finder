require File.dirname(File.expand_path(__FILE__)) + '/future_estimate'

module Weather

	class Day < Weather::FutureEstimate
		attr_reader :doc

		def initialize(doc)
			super(doc)
		end

	  	# Select day part in the doc
	  	def part
	    	day = nil
	    	(doc/"part").each do |d|
	      		if d.attributes["p"] == "d"
	        		day = d
	      		end
	    	end
	  	end

	end

end