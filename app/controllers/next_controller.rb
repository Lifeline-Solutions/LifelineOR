class NextController < ApplicationController
  before_action :authenticate_user!

  def index
    @next = Next.all
  end

  def show
    @next = Next.find(params[:id])
  end

  def new
    @next = Next.new
  end

  def create
    @next = Next.new(next_params)
    @next.user_id = current_user.id
    respond_to do |format|
      if @next.save
        format.html { redirect_to next_url(@next), notice: 'Next was successfully created.' }
      else
        format.html { redirect_to next_index_url, notice: 'Failure' }
      end
    end
  end

  def destroy
    @next = Next.find(params[:id])
    @next.delete
    respond_to do |format|
      format.html { redirect_to next_index_path, notice: 'Next was successfully deleted.' }
    end
  end

  def edit
    @next = Next.find(params[:id])
  end

  def update
    @next = Next.find(params[:id])
    respond_to do |format|
      if @next.update(next_params)
        format.html { redirect_to next_url(@next), notice: 'Next was successfully updated.' }
      else
        format.html { redirect_to next_index_url, notice: 'Failure' }
      end
    end
  end

  private

  def next_params
    params.require(:next).permit(:name, :relationship, :phone_number, :user_id)
  end
end
