class MeetupRequestsController < ApplicationController
  attr_reader :zip

  LOCATION_URL = "https://api.meetup.com/find/locations?key=636f679609123343506f6b68434319&sign=true&query="
  BASE_URL = "https://api.meetup.com/find/events?key=636f679609123343506f6b68434319&sign=true"

  def new

  end

  def new_meetup_request
    @zip = params[:zip]
    free_events

  end





  def location_query
    response = RestClient.get("#{LOCATION_URL}#{@zip}")
    location = JSON.parse(response).first
    "&lon=#{location['lon']}&lat=#{location['lat']}"
  end

  def fetch_events
    response = RestClient.get("#{BASE_URL}#{location_query}")
    events = JSON.parse(response)
  end

  def free_events
    all = fetch_events
    binding.pry
  end

end
