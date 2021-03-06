class Api::V1::TopTracksController < ApplicationController
  def create
    body = {top_tracks: params[:q]}
    # params taken in by the front end
    decoded = JWT.decode(my_user.access_token, ENV["MY_SECRET"], ENV["ES"])
    # taking the access token stored in user and decoding it
    header = {'Authorization': "Bearer " + decoded[0]["access_token"]}
    # iterating through decoded to get to the access token and passing it into the header
    top_tracks_response = RestClient.get("https://api.spotify.com/v1/artists/#{body[:top_tracks]}/top-tracks?country=US", header)
    top_tracks_params = JSON.parse(top_tracks_response.body)
    # making the fetch request to the spotify api and parsing it
    render json: {top_tracks: top_tracks_params}
    # rendering to the back end so the front end can take in the data
  end
end
