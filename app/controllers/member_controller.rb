class MemberController < ApplicationController
  def index
    auth = request.env["omniauth.auth"]
    #raise auth.to_yaml
    @member = Member.find_by_fbuid(auth["uid"])
    if @member
      signin @member
    else
      create auth
    end
  end

  def create auth
    @member = Member.create_member auth
    session[:user_id] = @member.id
    session[:fbuid] = @member.fbuid
    session[:email] = @member.email
    url = "#home/new"
    redirect_to url, :notice => "Signed up!"
  end

  def update
  end

  def fetch
    @member = Member.find(session[:user_id])
    respond_to do |format|
      format.json { render json:@member, status: :accepted}
    end
  end

  def destroy

  end

  def signin member
    session[:user_id] = member.id
    session[:fbuid] = member.fbuid
    session[:email] = member.email
    url = "#home"
    redirect_to url, :notice => "Signed in!"
  end

  def signout
    reset_session
    url = "#"
    redirect_to url, :notice => "Signed Out!"
  end
end
