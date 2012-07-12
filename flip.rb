require 'rubygems'
require 'bundler/setup'
require 'em-websocket'
require 'yajl'
require 'compass'
require 'coffee-script'
require 'sinatra/base'
require 'thin'

EventMachine.run do

  class Flip < Sinatra::Base
    @@channel = nil
    set :public_folder, "static"

    configure do
      Compass.add_project_configuration(File.join(root, 'config', 'compass.config'))
    end

    get '/css/:name.css' do
    #  content_type 'text/css', :charset => 'utf-8'
      scss(:"stylesheets/#{params[:name]}", Compass.sass_engine_options)
    end

    get '/js/:name.js' do
    #  content_type 'text/css', :charset => 'utf-8'
      coffee :"javascripts/#{params[:name]}"
    end

    get '/' do
      erb :flip
    end

    post '/' do
      @@channel.push(params[:message]) unless @@channel.nil?
    end

    def self.channel=(channel)
      @@channel = channel
    end

  end

  @channel = EM::Channel.new
  Flip.channel = @channel

  EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 8080) do |ws|
      ws.onopen {
        sid = @channel.subscribe { |msg| ws.send msg }
        ws.onclose {
          @channel.unsubscribe(sid)
        }
      }

  end

  Flip.run!({ :port => 3000 })

end