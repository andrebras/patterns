require "active_record"
require "models/user"

class UsersController < Controller
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(request["id"])
    response.write "<p>#{@user.name}</p>"
  end
end