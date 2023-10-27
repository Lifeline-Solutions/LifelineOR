class ExistController < ApplicationController
  def index; end

  def show
    @exist = Exist.find(params[:id])
  end

  def new
    @exist = Exist.new
  end

  def create
    @exist = Exist.new(exist_params)
    @exist.user_id = current_user.id
    respond_to do |format|
      if @exist.save
        format.html { redirect_to exist_index_url(@exist), notice: 'Exist was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity, notice: 'Failure' }
      end
    end
  end

  def destroy
    @exist = Exist.find(params[:id])
    @exist.delete
    respond_to do |format|
      format.html { redirect_to exist_index_url, notice: 'Exist was successfully deleted.' }
    end
  end

  private

  def exist_params
    params.require(:exist).permit(:condition, :private, :user_id)
  end
end
