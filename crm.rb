require_relative 'contact'
require_relative 'rolodex'
require 'sinatra'
require 'sinatra/reloader'

$rolodex = Rolodex.new

get '/'  do
	@crm_name = "My CRM"
	erb :index
end

get '/contacts' do
	@contacts = $rolodex.contacts
  erb :contacts
end

get '/contacts/new_contact' do
	erb :new_contact
end

get '/contacts/:id' do
	@contact = $rolodex.find_contact(params[:id].to_i)
	erb :contact
end

post '/contacts' do
	# p params: params
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	$rolodex.add_contact(new_contact)
	redirect '/contacts'
end