class User < ApplicationRecord
  # Class methods
  class << self
    def from_omniauth(auth)
      email = auth.info.email
      provider = auth.provider
      uid = auth.uid
      first_name = auth.info.name.split.first
      last_name = auth.info.name.split.last
      avatar_url = auth.info.image || ""

      where(provider: provider, uid: uid).first_or_create do |user|
        user.email = email
        user.provider = provider
        user.uid = uid
        user.password = Devise.friendly_token[0,20]
        user.create_profile(first_name: first_name, last_name: last_name, avatar_url: avatar_url)
      end
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  # Relations
  has_one :profile, dependent: :destroy
    
    ## Attribute for associations
    accepts_nested_attributes_for :profile

end
