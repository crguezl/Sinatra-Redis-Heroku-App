require 'rubygems'
require 'sinatra'
require 'erb'

configure do
  require 'redis'
  redisUri = ENV["REDISTOGO_URL"] || 'redis://localhost:6379'
  uri = URI.parse(redisUri) 
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

get '/' do
  r = Redis.new
  puts r.ping
  r.set('foo','bar')
  erb :index
end

get '/foo' do
  r = Redis.new
  z = r.get('foo')
  puts z
  erb :var, :locals => { :foo => z }
end

