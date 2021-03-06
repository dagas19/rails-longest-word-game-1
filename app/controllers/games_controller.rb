require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @random = ('a'..'z').to_a.sample(8)
    @start_time = Time.now.to_i
  end

def tester
  validator = true
  @attempt.chars.each do |char|
    validator = false unless @attempt.count(char) <= @letters.count(char)
  end
  validator
end

  def score
    @attempt = params[:attempt]
    @letters = params[:letters]
    @time_elapsed = Time.now.to_i - params[:start_time].to_i
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    answer = JSON.parse(open(url).read)
    tester
    if answer['found'] && tester
      @score = "Your score is #{answer['length'] * 10 / @time_elapsed}"
    else
      @score = 'Not a valid word'
    end
  end
end
