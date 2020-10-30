class User < ActiveRecord::Base
  has_many :plans
  has_secure_password #creates validate methods, you can set it to check specific things
  validates :username, presence: true #this is validating that in their input they have a username
  validates :username, uniqueness: true #this is validating that each password is unique
end
