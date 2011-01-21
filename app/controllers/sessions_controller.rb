class SessionsController < ApplicationController

  def new
    @title = 'Sign in'
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      sign_in user #old style call to sessions_helper to set up cookie
      #session[:user_id] = user.id #new style to create a session with the relevant id
      redirect_to user
    end
  end

  def destroy
    sign_out #old style call to sessions_helper to set up cookie
    #reset_session #new style for destroying existing session
    redirect_to root_path
  end

end
