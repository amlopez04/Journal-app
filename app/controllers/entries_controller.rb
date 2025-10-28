class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category
  before_action :set_entry, only: [ :show, :edit, :update, :destroy ]
  before_action :ensure_entry_owner, only: [ :edit, :update, :destroy ]

  def new
    @entry = @category.entries.build
  end

  def create
    @entry = @category.entries.build(entry_params)
    @entry.user = current_user

    if @entry.save
      redirect_to category_entry_path(@category, @entry), notice: "Entry was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @entry.update(entry_params)
      redirect_to category_entry_path(@category, @entry), notice: "Entry was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @entry.destroy
    redirect_to category_path(@category), notice: "Entry was successfully deleted."
  end

  private

  def set_category
    @category = current_user.categories.find(params[:category_id])
  rescue ActiveRecord::RecordNotFound
    head :forbidden
  end

  def set_entry
    @entry = @category.entries.find(params[:id])
  end

  def ensure_entry_owner
    unless @entry.user == current_user
      head :forbidden
    end
  end

  def entry_params
    params.require(:entry).permit(:title, :content)
  end
end
