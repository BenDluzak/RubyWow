require "rubygems"
require "sinatra"
require "bundler/setup"
require './controller/defineCharacter.rb'
require 'bundler/setup'
set :static, true
set :views, "view"
post "/character" do
  
  erb :characterResults
end
get "/" do
  erb :index
end

get "/character" do
  erb :character
end

get "/guild" do
  erb :guild
end

get "/arena" do
  erb :arena
end