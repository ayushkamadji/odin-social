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

  # Devise Authentication System
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  # Relations
  has_one :profile, dependent: :destroy
  has_many :as_first_user_friendships, class_name: 'Friendship', foreign_key: 'first_user_id'
  has_many :as_second_user_friendships, class_name: 'Friendship', foreign_key: 'second_user_id'
  has_many :posts
  has_many :comments, dependent: :destroy
    
    ## Attribute for associations
    accepts_nested_attributes_for :profile

  # Friend relation methods
  def friendships
    Friendship.where(id: 
                       (self.as_first_user_friendships.ids + 
                        self.as_second_user_friendships.ids)
                    )
  end

  def friends
    User
      .where(id: self.as_first_user_friendships.select(:second_user_id))
      .or(
    User
      .where(id: self.as_second_user_friendships.select(:first_user_id)))
  end
end
