class Member < ActiveRecord::Base
  attr_accessible :dob, :email, :fbuid, :firstname, :gender, :lastname, :location
  
  def self.create_member auth
    create! do |member|
      member.firstname = auth["info"]["first_name"]
      member.lastname = auth["info"]["last_name"]
      member.dob = auth["extra"]["raw_info"]["birthday"]
      member.gender = auth["extra"]["raw_info"]["gender"]
      member.email = auth["info"]["email"]
      #member.image_url = "default_profile_image.png"
      member.fbuid = auth["extra"]["raw_info"]["id"]
      member.location = auth["info"]["location"]
        #img = auth["info"]["image"]
        #url_parts = img.split('?')
        #img_path = url_parts[0] + "?type=large"
        #member.image_url = img_path
    end
  end
end
