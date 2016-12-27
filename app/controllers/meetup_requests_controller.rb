class MeetupRequestsController < ApplicationController
  attr_reader :zip

  LOCATION_URL = "https://api.meetup.com/find/locations?key=636f679609123343506f6b68434319&sign=true&query="
  BASE_URL = "https://api.meetup.com/find/events?key=636f679609123343506f6b68434319&sign=true"

  def new_meetup_request
  # Called when the submit button is clicked on meetup_requests/new.html.erb
    @zip = params[:zip]
    free_events
  end



  def location_query  # Returns a longitude/latitude query string for requesting events
    response = RestClient.get("#{LOCATION_URL}#{@zip}")
    location = JSON.parse(response).first
    "&lon=#{location['lon']}&lat=#{location['lat']}"
  end

  def fetch_events  # Returns an array of hashes with all the events around the given zipcode
    response = RestClient.get("#{BASE_URL}#{location_query}")
    events = JSON.parse(response)
  end

  def free_events   # Returns an array of hashes with only free events, and only key/value pairs that we're using
    # WIP
    all = fetch_events
    binding.pry
  end

end
