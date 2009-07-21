require "net/http"
require "cgi"
require "hpricot"
require "memcache"

require File.dirname(File.expand_path(__FILE__)) + '/forecast'

module Weather

	class WeatherFinder
		attr_accessor :partner_id, :license_key
		
		# Weather.com HOST
	 	XOAP_HOST = "xoap.weather.com"

		# Default unit ajusted to Farenheit degrees :)
	  	def load_forecast(location_id, days = 1, unit = 's')
		    # URL to fetch the forecast from Weather.com
		    url = "/weather/local/#{location_id}?cc=*&dayf=#{days}&par=#{partner_id}&key=#{license_key}&unit=#{unit}"

			if (cache_ok?)
				# Retrieving data from cache
				xml = @cache.get("#{location_id}:#{days}")
			end

			if (xml == nil)
				# Retrieving the XML doc from weather.com
			    xml = Net::HTTP.get(XOAP_HOST, url)
				
			    if (cache_ok?)
					# Setting data on the cache
		    		@cache.set("#{location_id}:#{days}", xml.to_s, cache_expiry)
		    	end
			end

			# Using Hpricot to parse the data
			doc = Hpricot.XML(xml)

			# Passing doc to the Forecast object
			Weather::Forecast.new(doc)
	  	end

		def find_location_id(search_string)
		    # URL encode
		    url = "/weather/search/search?where=#{CGI.escape(search_string)}"

		    # Retrieving the XML doc
		    xml = Net::HTTP.get(XOAP_HOST, url);

		    # Using Hpricot to parser the data
		    doc = Hpricot.XML(xml)
			location_id = doc.at("/search/loc")["id"]
	  	end

		# Enables cache
		def enable_cache
			@enable_cache = true
		end

		# Disables cache
		def disable_cache
			@enable_cache = false
		end

		# Defines default expiration time in seconds (ten minutes)
		def cache_expiry=(seconds)
			@cache_expiry = seconds
		end

		# Defines expiration time in seconds
		def cache_expiry
			@cache_expiry || 60 * 10
      	end

		# Used to instantiate the MemCache
		def cache
			@cache ||= MemCache.new(:namespace => 'Weather')
		end

		# Verifies if the cache is enabled and actived
		def cache_ok?
			@enable_cache and 
			@cache.active? and 
			servers = @cache.instance_variable_get(:@servers) and 
		    servers.collect{|s| s.alive?}.include?(true)
		end

	end

end