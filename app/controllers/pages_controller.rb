class PagesController < ApplicationController
  def welcome
    if request.post?
      session[:zipcode] = params[:zipcode]
      redirect_to pages_weather_path
    end

  end
  
  def weather
    @zipcode = session[:zipcode]
    require 'net/http'
    require 'json'
    if @zipcode.present?
      @url = "http://api.weatherapi.com/v1/current.json?q=#{@zipcode}&key=887155fa16f441a783d34634251501"
    else
      @url = "http://api.weatherapi.com/v1/current.json?q=43201&key=887155fa16f441a783d34634251501"
    end
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)
    if @output.key?("error")
      @final_output = "Error: " + @output["error"]["message"]
    else
      @final_output = @output
    end
    puts(@final_output)
  end
  
end
