class MemberController < ApplicationController
  def index
    auth = request.env["omniauth.auth"]
    #raise auth.to_yaml
    @member = Member.find_by_fbuid(auth["uid"])
    if @member
      signin auth
    else
      create auth
    end
  end

  def create auth
    @member = Member.create_member auth
    session[:user_id] = @member.fbuid
    session[:email] = @member.email
    reset_session
    url = "#welcome"
    redirect_to url, :notice => "Signed in!"
  end

  def update
  end

  def fetch
  end

  def destroy

  end

  def signin
  end

  def signout
    reset_session
    url = "#welcome"
    redirect_to url, :notice => "Signed Up!"
  end
end
