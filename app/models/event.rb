class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :attended, dependent: :destroy
  has_many :attendees, through: :attended, source: :users
  validates :name, :location, :date, :state, presence: true
  validates :state, length: {is: 2}
  validates :date, { after: Proc.new { Time.now } }
end
