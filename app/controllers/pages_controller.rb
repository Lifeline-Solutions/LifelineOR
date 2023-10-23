class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @bio = Bio.all
    @consultations = Consultation.where(
      start_time: Time.zone.now.beginning_of_month.beginning_of_week..Time.zone.now.end_of_month.end_of_week
    )
    @profile = Profile.all
  end
end
