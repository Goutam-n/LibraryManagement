class UserMailer < ApplicationMailer
  def welcome_email(user)
    
    @user = user
		puts "================     Inside Mailer    ========================"
    mail(to: user.email, subject: 'Welcome to Our App')
  end
end


