class ContactsController < ApplicationController
  # @contact = instance variable; sets our new contact form = to @contact %>
  # GET request to /contact-us
  #Show new contact form
  def new
    @contact = Contact.new
     
  end
    # Post request /contacts
    # saving completed form to the database; (contact_params) = form fields assigned to object "mass assignment"
    def create
      # Mass assignment of from fields into Contact object
      @contact = Contact.new(contact_params)
      # Save the Contact object to the database
      if @contact.save
        # Store form fields via parameters into variables
        # lifting contact form info to send with mailer
        name = params[:contact][:name]
        email = params[:contact][:email]
        body = params[:contact][:comments]
        # Plug variables into the Contact Mailer email method and send email
        ContactMailer.contact_email(name, email, body).deliver
        # Store success message in flash hash
        # and redirect to the new action
        # Submit contact form success message
        flash[:success] = "Message Sent"
        redirect_to new_contact_path
      else
        # If Contat object doesn't save, store errors in flash hash
        # and redirect to the new action
        flash[:danger] = @contact.errors.full_messages.join(", ")
        redirect_to new_contact_path
      end
    end
    
    private 
    # To collect data from form we need to use strong parameters
    # and whitelist the form fields
    def contact_params
        params.require(:contact).permit(:name, :email, :comments)
    end
end