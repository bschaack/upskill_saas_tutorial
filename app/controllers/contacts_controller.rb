class ContactsController < ApplicationController
  # @contact = instance variable; sets our new contact form = to @contact %>
  def new
    @contact = Contact.new
     
  end
    # saving completed form to the database; (contact_params) = form fields assigned to object "mass assignment"
    def create
      @contact = Contact.new(contact_params)
      if @contact.save
        name = params[:contact][:name]
        email = params[:contact][:email]
        body = params[:contact][:comments]
        ContactMailer.contact_email(name, email, body).deliver
        flash[:success] = "Message Sent"
        redirect_to new_contact_path
      else
        flash[:danger] = @contact.errors.full_messages.join(", ")
        redirect_to new_contact_path
      end
    end
    
    private # private methods can only be executed within this file
    # using strong parameters to securely save to the db
      def contact_params
        params.require(:contact).permit(:name, :email, :comments)
      end
end