class PagesController < ApplicationController
  def index
    redirect_to(todos_path) if signed_in?
  end
end
 