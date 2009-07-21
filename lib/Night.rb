require File.dirname(File.expand_path(__FILE__)) + '/future_estimate'

module Weather

	class Night < Weather::FutureEstimate
		attr_reader :doc

		def initialize(doc)
	    	super(doc)
		end

	  	# Select night part in the doc
	  	def part
	    	night = nil
	    	(doc/"part").each do |d|
	      		if d.attributes["p"] == "n"
	        		night = d
	      		end
	    	end
	  	end

	end

end