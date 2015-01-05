class Event < ActiveRecord::Base

  belongs_to :user

  has_many :attending_events
  has_many :attendees, through: :attending_events, source: :user

end
