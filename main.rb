require 'sinatra'
require 'slim'
require 'sass'
require './song'

configure do 
	enable :sessions
	set :username, 'frank'
	set :password, 'sinatra'
end

get '/login' do
	slim :login
end

post '/login' do
	session[:name] = params[:username]
	if params[:username] == settings.username && params[:password] == settings.password
		session[:admin] = true
		redirect to('/songs')
	else
		#session.clear
		#session[:admin] = false
		slim :login
	end
end

get '/logout' do
	session.clear
	redirect to('/login')
end

get '/set/:name' do 
	session[:name] = params[:name]
end

get '/get/hello' do
	"Hello #{session[:name]}"
end

get('/styles.css'){ scss :styles }

get '/' do 
	slim :home
end

get '/about' do
	@title = "All about this website"
	slim :about
end

get '/contact' do
	slim :contact
end

not_found do
	slim :not_found
end
#