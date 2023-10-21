class PagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @bio = Bio.all.order('created_at DESC')
  end
end
