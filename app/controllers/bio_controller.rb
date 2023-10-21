class BioController < ApplicationController
  before_action :authenticate_user!

  def index
    @bio = Bio.all.order('created_at DESC')
  end

  def show
    @bio = Bio.find(params[:id])
  end

  def new
    @bio = Bio.new
  end

  def create
    @bio = Bio.new(bio_params)
    @bio.user_id = current_user.id
    respond_to do |format|
      if @bio.save
        format.html { redirect_to bio_index_path, notice: 'Bio was successfully created.' }
      else
        format.html { redirect_to bio_index_url notice: 'Failure' }
      end
    end
  end

  def destroy
    @bio = Bio.find(params[:id])
    @bio.delete
    respond_to do |format|
      format.html { redirect_to bio_index_path, notice: 'Bio was successfully deleted.' }
    end
  end

  def edit
    @bio = Bio.find(params[:id])
  end

  def update
    @bio = Bio.find(params[:id])
    respond_to do |format|
      if @bio.update(bio_params)
        format.html { redirect_to bio_index_path(@bio), notice: 'Bio was successfully updated.' }
      else
        format.html { redirect_to bio_index_url, notice: 'Failure' }
      end
    end
  end

  private

  def bio_params
    params.require(:bio).permit(:date_of_birth, :language, :home_town, :about_me, :user_id)
  end
end
