require "httparty"
require "json"
require "dotenv-rails"
require 'cancancan'
require "caller"
require "callerdummy"

class PagesController < ApplicationController

  def home
     @users = User.all
	 if (current_user)
	    @user=current_user
		  categoria=@user.favorite_category
		  if categoria && categoria!="nessuna categoria"
		    call = Caller.new
        @search_results =call.find_by_category(categoria)
		  end
	 end
  end

  def cambia 
      locale = params[:locale].to_sym
      I18n.locale = locale
      session[:select_l] = I18n.locale
      redirect_to root_path
  end
  

def search
    @users=User.all
    @keyword=params[:keyword]
    @sort_order=params[:sort_order]
    @minprice= params[:minprice].to_i 
    @maxprice=params[:maxprice].to_i
    @instaexp=params[:instaexp].to_i
    @place=params[:place]
    @minf=params[:minf]
    @maxtime=params[:maxtime]
    

    if (current_user)
      @user=current_user
      reviews = Review.where(user_id: @user.id).pluck(:item_id)
      @reviews_item_id = reviews
      researches = Research.where(user_id: @user.id).pluck(:item_id)
      @researches_item_id = researches
      cercaitem=Research.where(user_id: @user.id).pluck(:item_id, :price)
      @resitem=cercaitem
    end

    chiamatad=Callerdummy.new
    chiamata = Caller.new
    @search_results =chiamata.cerca(params[:keyword], params[:sort_order], params[:minprice].to_i, params[:maxprice].to_i,params[:instaexp].to_i, params[:place],params[:minf], params[:maxtime])
    semi=chiamatad.cerca

    @search_dummy=semi["products"]
    @risultato=[]

    
    luoghi=[" IT"," US","US","US","IT"]

    
    @search_dummy.each do |item| 
      if item["title"].downcase.include?(@keyword.downcase)
            oggetto={}
            negozio=item["negozio"]
            itemd=item["id"]
            titled=item["title"] 
            feedm=item["rating"].round*20+rand(50)
            priced=item["price"]
            location=luoghi.sample
            timed=rand(5)+1
            iexp=rand(2)
            currency= " USD"
            urld="random"
            if item["price"]<@minprice || item["price"]>@maxprice || feedm<@minf.to_i || timed>@maxtime.to_i || iexp!=@instaexp
              next
            end
            oggetto["title"]=titled
            oggetto["item_id"]=itemd
            oggetto["feed"]=feedm
            oggetto["price"]=priced.to_i
            oggetto["location"]=location
            oggetto["time"]=timed
            oggetto["url"]=urld
            if @instaexp==1
            oggetto["iexp"]="true"
            else
            oggetto["iexp"]="false"
            end
            oggetto["negozio"]="Dummy"
            oggetto["currency"]=currency

            @risultato.push(oggetto)
      
      end
    end

    if (@search_results!=nil)

        @search_results.each do |item| 
            oggetto={}
            negozio=item["negozio"]
            title=item["title"][0] 
            feed=item["sellerInfo"][0]["feedbackScore"][0].to_i
            time=item["shippingInfo"][0]["handlingTime"][0].to_i
            price=item["sellingStatus"][0]["currentPrice"][0]["__value__"]
            currency=item["sellingStatus"][0]["currentPrice"][0]["@currencyId"] 
            url=item["viewItemURL"][0] 
            location=item["location"][0] + "  " + item["country"][0]
            iexp=item["listingInfo"][0]["buyItNowAvailable"][0]=="true" 
            itemid=item["itemId"][0].to_i
            oggetto["title"]=title
            oggetto["item_id"]=itemid
            oggetto["feed"]=feed
            oggetto["price"]=price.to_i
            oggetto["location"]=location
            oggetto["time"]=time
            oggetto["url"]=url
            oggetto["iexp"]=iexp
            oggetto["negozio"]="Ebay"
            oggetto["currency"]=currency
            @risultato.push(oggetto)
        end 
      end

    if @sort_order=="PricePlusShippingLowest" 
      res=@risultato.sort_by { |k| k["price"] }      
      @risultato=res

    end 
    if @sort_order=="PricePlusShippingHighest" 
      res=@risultato.sort_by { |k| -k["price"] }      
      @risultato=res
   end 
    if @sort_order=="Feed" 
      res=@risultato.sort_by { |k| -k["feed"] }      
      @risultato=res
    end
    if @sort_order=="Time" 
      res=@risultato.sort_by { |k| -k["time"] }      
      @risultato=res
    end
    if @instaexp==1
        res=@risultato.select { |k| k["iexp"]== "true"}
        @risultato=res
    end
end
end
