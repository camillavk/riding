class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :events

  has_many :attending_events
  has_many :attending, through: :attending_events, source: :event

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

         def self.from_omniauth(auth)
           where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
             user.email = auth.info.email
             user.password = Devise.friendly_token[0,20]
             # Need to add name and image to user model in devise first;
             user.name = auth.info.name
            #  user.image = access_token.info.image
           end
         end

         def self.new_with_session(params, session)
           super.tap do |user|
             if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
               user.email = data["email"] if user.email.blank?
               user.name = data["name"] if user.name.blank?
              #  user.image = data["image"] if user.image.blank?
              #  user.image = access_token.info.image
             end
           end
         end
end
