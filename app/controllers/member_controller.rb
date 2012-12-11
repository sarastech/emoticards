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
    url = "#home"
    redirect_to url, :notice => "Signed up!"
  end

  def update
  end

  def fetch
    #@fullmember = []
    @member = Member.find(session[:user_id])
    #@message = Message.find_by_member_id(session[:user_id])
    #@fullmember.push({ member: @member, message: @message.message })
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
  
  def get_message
    @message = Message.find_by_member_id(session[:user_id])
    respond_to do |format|
      format.json { render json: @message , status: :accepted}
    end
  end
  
  def save_message
    params[:message].delete :wait
    params[:message][:member_id] = session[:user_id] 
    @message = Message.new(params[:message])
    if @message.save
      respond_to do |format|
        format.json { render json: @message , status: :accepted}
      end
    else
      respond_to do |format|
        format.json { render status: :not_acceptable }
      end  
    end
  end

  def message_count
    @member = Member.all
    respond_to do |format|
      format.json {render json: {count: @member.length} , status: :accepted }
    end
  end
  
end
