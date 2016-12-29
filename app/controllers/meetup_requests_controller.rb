class MeetupRequestsController < ApplicationController

  LANGUAGE_URL = "https://api.meetup.com/find/topics"
  EVENTS_URL = "https://api.meetup.com/2/open_events"
  KEY = "636f679609123343506f6b68434319"
  TECH_CATEGORY = "34"
  Q_PARAMS = {sign: true, key: KEY}

  # ACTIONS
  def index
  end

  def new_meetup_request
  # Called when the submit button is clicked on meetup_requests/new.html.erb
    Event.destroy_all
    free_events
    redirect_to events_url
  end

  private

  # HELPERS
  def events_query
    query = {}
    query = Q_PARAMS
    query[:topic] = get_language
    query[:zip] = params[:zip]
    query
  end

  def get_language  # Returns a string of Meetup API recognizable topics, based on language selected
    query = {}
    query = Q_PARAMS
    query[:query] = params[:topic]
    response = RestClient.get("#{LANGUAGE_URL}", params: query)
    topics = JSON.parse(response).map{|topic| topic['urlkey']}.join(',')
  end

  def fetch_events  # Returns an array of hashes with all the events around the given zipcode
    response = RestClient.get("#{EVENTS_URL}", params: events_query)
    events = JSON.parse(response)['results']
  end

  def free_events   # Returns an array of hashes with only free events, and only key/value pairs that we're using
    all = fetch_events
    free_events = all.select {|k,v| k['fee'] == nil}
    free_events.each {|event| Event.create(
      name: event['name'],
      link: event['event_url'],
      group: event['group']['name'].upcase,
      group_slug: event['group']['urlname'],
      date_time: DateTime.strptime((event['time']/1000).to_s, '%s').in_time_zone("Eastern Time (US & Canada)").strftime('%b %e, %Y %l:%M%p'),
      description: event['description']
    )}
  end

end
