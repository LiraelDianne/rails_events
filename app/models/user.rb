class User < ActiveRecord::Base
  has_many :events
  has_many :comments
  has_many :attended
  has_many :events_joined, through: :attended, source: :events
  has_secure_password
  validates :first_name, :last_name, :email, presence: true, length: {in: 2...50}
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, uniqueness: {case_sensitive: false}, format: {with: email_regex} 
end
