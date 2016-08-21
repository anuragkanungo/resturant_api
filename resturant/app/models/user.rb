class User < ApplicationRecord
  has_secure_password
  validates :name, :email, :address, :phone,  presence: true, on: :create
  validates :email, uniqueness: { case_sensitive: false }, on: :create
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :role, inclusion: { in: %w(admin manager customer),
    message: "%{value} is not a valid role" }, allow_nil: false
  has_many :orders

   # Exclude password info from xml output.
   def to_xml(options={})
     options[:except] ||= [:password_digest]
     super(options)
   end

   # Exclude password info from json output.
   def as_json(options={})
     options[:except] ||= [:password_digest]
     super(options)
   end
end
