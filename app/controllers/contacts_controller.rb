class ContactsController < ApplicationController
  
  #GET Request /Contact-US
  #Show new contact form
  def new
    @contact = Contact.new
  end
  
  #POST request /Contacts
  def create
    #Mass assignment of form fields into Contact object
    @contact = Contact.new(contact_params)
    #Save the Contact object to the database
    if @contact.save
      #Store formfields via perameters into variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      #Plug variables into Contact Mailer e-mail method & send e-mail
      ContactMailer.contact_email(name, email, body).deliver
      #Store Success Message 
      #And Redirect to the new action
      flash[:success] = "Message sent."
      redirect_to new_contact_path
    else
      #If Contact object doesn't save
      #Store errors in Flash hash
      #and redirect to new action
       flash[:danger] = @contact.errors.full_messages.join(", ")
       redirect_to new_contact_path
    end
  end
  
  private
  #To collect data from form we need to use strong perameters
  #And white list form fields
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
end