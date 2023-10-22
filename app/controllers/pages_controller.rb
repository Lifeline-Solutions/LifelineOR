class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @bio = Bio.all
  end
end
