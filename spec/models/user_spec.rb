require 'rails_helper'

  RSpec.describe User, type: :model do
    let(:user) { create(:user, favorite_category: "Elettronica") }
  
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end
  
    it "is not valid without an email" do
      user.email = nil
      expect(user).not_to be_valid
    end
  
    it "is not valid without a password" do
      user.password = nil
      expect(user).not_to be_valid
    end
  
    it "has an avatar_thumbnail method that returns a default URL when no avatar is attached" do
      expect(user.avatar_thumbnail).to eq("/assets/default_profile.jpg")
    end
  
  
    it "is an admin" do
      user.role = 1
      expect(user.admin?).to be true
    end
  
    it "is a moderator" do
      user.role = 2
      expect(user.moderator?).to be true
    end
  
    it "is not an admin or moderator by default" do
      expect(user.admin?).to be false
      expect(user.moderator?).to be false
    end
  
    it "can create a user from OmniAuth data" do
      auth = OmniAuth::AuthHash.new(provider: 'google_oauth2', uid: '123456', info: { email: 'test@example.com', name: 'Joe', image: 'avatar_url' })
      created_user = User.from_omniauth(auth)
      expect(created_user.email).to eq('test@example.com')
      expect(created_user.full_name).to eq('Joe')
      expect(created_user.avatar_url).to eq('avatar_url')
    end
  end
