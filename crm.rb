require_relative 'contact'
require_relative 'rolodex'
require 'sinatra'
require 'sinatra/reloader'

$rolodex = Rolodex.new
$rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bravo.com", "Rockstar"))
$rolodex.add_contact(Contact.new("Day Z.", "Kutter", "daisy@cutter.com", "Knife guy"))
$rolodex.add_contact(Contact.new("Derek", "Zoolander", "derek@cfkwcrg.com", "Supermodel"))

$crm_name = "My CRM"

get '/'  do
	@title = "Home - #{$crm_name}"
	erb :index
end

get '/contacts' do
	@title = "Contacts - #{$crm_name}"
	@contacts = $rolodex.contacts
  erb :contacts
end

get '/contacts/new_contact' do
	@title = "New Contact - #{$crm_name}"
	erb :new_contact
end

post '/contacts' do
	# p params: params
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	$rolodex.add_contact(new_contact)
	redirect '/contacts'
end

get '/contacts/:id' do
	@contact = $rolodex.find_contact(params[:id].to_i)
	if @contact
		@title = "#{@contact.first_name} #{@contact.last_name} - #{$crm_name}"
    erb :contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/edit" do
	@contact = $rolodex.find_contact(params[:id].to_i)
	if @contact
		@title = "Edit Contact - #{$crm_name}"
		erb :edit_contact
	else
		raise Sinatra::NotFound
	end
end

puts "/contacts/:id" do
	@contact = $rolodex.find_contact(params[:id].to_i)
	if @contact
		@contact.first_name = params[:first_name]
		@contact.first_name = params[:last_name]
		@contact.first_name = params[:email]
		@contact.first_name = params[:note]

		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end