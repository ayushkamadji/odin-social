class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]


  class << self
    def from_omniauth(auth)
      email = auth.info.email
      provider = auth.provider
      uid = auth.uid

      where(provider: provider, uid: uid).first_or_create do |user|
        user.email = email
        user.provider = provider
        user.uid = uid
        user.password = Devise.friendly_token[0,20]
      end
    end
  end
end
