class ProfilesController < ApplicationController
  def edit
  end

  def update
    if Current.user.update(user_params)
      redirect_to edit_profile_path, notice: "Your profile was updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [ :name ])
  end
end
