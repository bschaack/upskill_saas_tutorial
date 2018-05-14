class ContactsController < ApplicationController
  # @contact = instance variable; sets our new contact form = to @contact %>
  def new
    @contact = Contact.new
     
  end
    # saving completed form to the database; (contact_params) = form fields assigned to object "mass assignment"
    def create
      @contact = Contact.new(contact_params)
      if @contact.save
        redirect_to new_contact_path, notice: "Message sent."
      else
        redirect_to new_contact_path, notice: "Error occured"
      end
    end
    
    private # private methods can only be executed within this file
    # using strong parameters to securely save to the db
      def contact_params
        params.require(:contact).permit(:name, :email, :comments)
      end
end