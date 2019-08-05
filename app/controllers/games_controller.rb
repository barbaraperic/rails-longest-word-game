require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = [*('A'..'Z')].to_a.sample(10).join(" ")
  end

  def score
    @word = params[:word]
    @letters = params[:grid]
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def english_word?(word)
  url = "https://wagon-dictionary.herokuapp.com/" + word
  data = open(url).read
  json = JSON.parse(data)
  json ['found']
  end

  def included?(word, letter)
    word.chars.all? {|letter| word.count(letter) <= letter.count(letter)}
  end
end

