require 'rails_helper'
require "./spec/factories/user.rb"


RSpec.describe PagesController, type: :controller do
  
  
  describe "GET #home" do
    it "returns a successful response" do
      get :home
      expect(response).to be_successful
    end

    it "assigns the current user" do
      get :home
      expect(assigns(:user)).to eq(user)
    end

    it "assigns search results if the user has a favorite category" do
      get :home
      expect(assigns(:search_results)).not_to be_nil
    end

    it "does not assign search results if the user has no favorite category" do
      user.update(favorite_category: "nessuna categoria")
      get :home
      expect(assigns(:search_results)).to be_nil
    end
  end
  
  describe 'GET #search' do
    it 'assigns instance variables and renders the template' do
      get :search, params: {
        keyword: 'lamp',
        sort_order: 'PricePlusShippingLowest',
        minprice: 0,
        maxprice: 100,
        instaexp: 1,
        place: 'US',
        minf: '0',
        maxtime: '10'
      }

      expect(assigns(:users)).to be_a(ActiveRecord::Relation)
      expect(assigns(:keyword)).to eq('lamp')
      expect(assigns(:sort_order)).to eq('PricePlusShippingLowest')
      expect(assigns(:minprice)).to eq(0)
      expect(assigns(:maxprice)).to eq(100)
      expect(assigns(:instaexp)).to eq(1)
      expect(assigns(:place)).to eq('US')
      expect(assigns(:minf)).to eq('0')
      expect(assigns(:maxtime)).to eq('10')

      # Add more expectations for other instance variables as needed

      expect(response).to render_template(:search)
    end

  end
  
   describe 'GET #search' do
    it 'assigns a non-empty @search_results' do
      # Stub the external service that is being called in the controller
      allow_any_instance_of(Caller).to receive(:cerca).and_return([
        { 'title' => 'Item 1', 'price' => 10 }
      ])

      get :search, params: {
        keyword: 'lamp',
        sort_order: 'PricePlusShippingLowest',
        minprice: 0,
        maxprice: 100,
        instaexp: 1,
        place: 'US',
        minf: '0',
        maxtime: '10'
      }

      expect(assigns(:search_results)).not_to be_nil
    end
  end
end