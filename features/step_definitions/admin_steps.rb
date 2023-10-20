Given('I am a admin') do
    @user=FactoryBot.create(:admin)
end
  
And("I am on the Sign in Page admin")do
  visit "http://127.0.0.1:3000/users/sign_in"
end
  
  When('I insert email email and password admin') do
    fill_in("user_email", with: @user.email)
    fill_in("user_password", with: @user.password)
  end
  
  When('I click button {string} admin') do |string|
    click_button(string)
  end
  
  Then('I am redirected to Home Page admin') do
    expect(current_path).to eq(root_path)
  end
  

Given('there is a user') do
    @user=FactoryBot.create(:user)
end
  
And('I m on admin board') do
    visit "http://127.0.0.1:3000/admin_board"
end
  
  When('i click delete for a user') do
    click_button("Elimina", match: :first)
end
  
  Then('i should not see the user') do
    expect(page).not_to have_text(@user.email)
end
  
  Then('the user should be removed from database') do
    user=User.find_by(id: @user.id)
    expect(user).to be_nil
end
  
  Given('there is a user not moderator') do
    @utente=FactoryBot.create(:user)
end
  
And('I m on a admin board') do
    visit "http://127.0.0.1:3000/admin_board"
end
  
  When('i click make mod for a user') do
    click_link("Rendi mod", match: :first)
end
  
  Then('the user should be a moderator') do
    @utente.reload
    expect(@utente.role).to eq(2)
end
  
  Given('there is a moderator user') do
    @utente=FactoryBot.create(:moderator)
end

And('I m on a admin board') do
    visit "http://127.0.0.1:3000/admin_board"
end  

  When('i click remove mod for a user') do
    click_link("Rimuovi mod", match: :first)
end
  
Then ("the user should not be a moderator") do
    @utente.reload
    expect(@utente.role).to eq(0)
end

Given ("there is a user and has a review") do
    @utente=FactoryBot.create(:user)
    @rece=FactoryBot.create(:reviewa)
end

And ("I am on admin board") do   
    visit "http://127.0.0.1:3000/admin_board"
end

When('i click on profilo of a user') do
    click_link("Profilo", match: :first)
end
  
  Then('I should be redirected to user s profilo') do
    expect(current_url).to match("http://127.0.0.1:3000/users/2")
end
  
  When('i click on elimina review button') do
    click_link("Elimina", match: :first)
end
    
Then('the review should disappear from db') do
    rece=Review.find_by(id: @utente.id)
    expect(rece).to be_nil
end
  