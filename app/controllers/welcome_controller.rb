class WelcomeController < ApplicationController

  def index
    if user_signed_in?
      redirect_to :controller => 'events', :action => 'index'
    end
  end

end
