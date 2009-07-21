require "test/unit"

require File.dirname(__FILE__) + '/../lib/weatherfinder'

class WeatherFinderTest < Test::Unit::TestCase
	LOCATION_ID = "BRXX0093"

  	def setup
    	@service = Weather::WeatherFinder.new
		@service.partner_id = "1094780686"
		@service.license_key = "d2f90d27351df0a8"
    	@forecast = @service.load_forecast(LOCATION_ID, 2, "m")
  	end

  	def teardown
    	@service = nil
    	@forecast = nil
  	end

	def test_retrieve_data_from_cache
		@service.enable_cache
		@service.cache.servers = "localhost:11211"
		@service.load_forecast(LOCATION_ID, 2, "m")
		xml = @service.cache.get("#{LOCATION_ID}:2")
		assert xml and !xml.empty
	end

	def test_retrieve_data_from_cache_with_expiration
		@service.enable_cache
		@service.cache.servers = "localhost:11211"
		@service.cache_expiry = 1
		@service.load_forecast(LOCATION_ID, 3, "m")
		sleep(2)
		assert_nil @service.cache.get("#{LOCATION_ID}:3")
	end

	def test_retrieve_data_with_cache_disabled
		@service.disable_cache
		assert !@service.cache_ok?
	end

  	def test_find_location_id
    	location_id = @service.find_location_id("Fortaleza")
    	assert_equal LOCATION_ID, location_id

    	# Testing locations with spaces
    	location_id = @service.find_location_id "Rio de Janeiro"
    	assert_equal "BRXX0201", location_id
  	end

	def test_load_forecast_fahrenheit
  		forecast = @service.load_forecast(LOCATION_ID, 2, "s")

    	assert_equal "Fortaleza, Brazil", forecast.location_name
    	assert_equal LOCATION_ID, forecast.location_id
    	assert_equal "F", forecast.temp_unit
    	assert_equal "mi", forecast.distance_unit
    	assert_equal "mph", forecast.speed_unit
	    assert_equal "in", forecast.precipitation_unit
    	assert_equal "in", forecast.presure_unit
  	end

	def test_load_forecast_celsius
  		forecast = @service.load_forecast(LOCATION_ID, 2, "m")

	    assert_equal "Fortaleza, Brazil", forecast.location_name
	    assert_equal LOCATION_ID, forecast.location_id
	    assert_equal "C", forecast.temp_unit
	    assert_equal "km", forecast.distance_unit
	    assert_equal "km/h", forecast.speed_unit
	    assert_equal "mb", forecast.precipitation_unit
	    assert_equal "mm", forecast.presure_unit
	end  

  	def test_load_forecast_with_current_conditions
    	assert_nothing_raised do
			@forecast.current.description
	      	@forecast.current.temp
	      	@forecast.current.icon
	      	@forecast.current.date
	      	@forecast.current.last_update
    	end
  	end

  	def test_load_current_wind_conditions
    	assert_nothing_raised do
			@forecast.current.wind.speed
	      	@forecast.current.wind.gust_speed
	      	@forecast.current.wind.direction
	      	@forecast.current.wind.description
    	end
	end

  	def test_tomorrow_forecast
    	assert_nothing_raised do
			@forecast.tomorrow.high
	      	@forecast.tomorrow.low
	      	@forecast.tomorrow.sunrise
	      	@forecast.tomorrow.sunset
	      	@forecast.tomorrow.icon
	      	@forecast.tomorrow.description
	      	@forecast.last_update
    	end
  	end

  	def test_day_forecast
    	assert_nothing_raised do
			@forecast.day(1).icon
	      	@forecast.day(1).description
	      	@forecast.day(1).precipitation
	      	@forecast.day(1).humidity
    	end
  	end

  	def test_night_forecast
    	assert_nothing_raised do
      		@forecast.night(1).icon
	    	@forecast.night(1).description
	      	@forecast.night(1).precipitation
	      	@forecast.night(1).humidity
    	end
  end

  	def test_day_wind_forecast
    	assert_nothing_raised do
      		@forecast.day(1).wind.speed
      		@forecast.day(1).wind.gust_speed
      		@forecast.day(1).wind.direction
      		@forecast.day(1).wind.description
    	end
	end

  	def test_night_wind_forecast
    	assert_nothing_raised do
      		@forecast.night(1).wind.speed
      		@forecast.night(1).wind.gust_speed
      		@forecast.night(1).wind.direction
      		@forecast.night(1).wind.description
    	end
  	end

end