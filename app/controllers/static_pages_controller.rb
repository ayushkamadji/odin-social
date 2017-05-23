class StaticPagesController < Devise::RegistrationsController
  def home
    unless signed_in?
      new do |user|
        user.build_profile
      end
    else
      redirect_to current_user and return
    end
  end
end
