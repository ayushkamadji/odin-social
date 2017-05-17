class StaticPagesController < Devise::RegistrationsController
  def home
    new do |user|
      user.build_profile
    end
  end
end
