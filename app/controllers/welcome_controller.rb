class WelcomeController < ApplicationController
layout "welcome"

  def index
    if user_signed_in?
      redirect_to '/events'
    end
  end

end
