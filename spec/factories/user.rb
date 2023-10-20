
FactoryBot.define do
    factory :user do
      email { 'test@example.com' }
      password { 'password' }
      full_name { 'John Doe' }
      uid { '12345' }
      avatar_url { 'http://example.com/avatar.png' }
      role { 0 }
      favorite_category { "Elettronica" }
    end
  end
  