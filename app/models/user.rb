class User < ApplicationRecord
  has_many :books, dependent: :destroy
  
  before_validation :normalize_name, on: :create
  before_validation :normalize_name, on: :update
  
  validates :name, presence: true
  validates :name, length: { minimum: 2 }
  # validates :age, presence: true, if: (:age > 18) 

  
  validates :email, confirmation: true
  validates :email_confirmation, presence: true
  validates :email, uniqueness: {
     message: ->(object, data) do
        "Hey #{object.name}, #{data[:value]} is already taken."
      end
  }
  
  validates :name, exclusion: { in: %w(admin administrator),
    message: "%{value} is reserved." }
  
  validates :email, format: { with: /A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, 
    message: " must be valid" }
    
  validates :age, numericality: { only_integer: true }
  validates :occupation, length: { in: 2..20 }, allow_blank: true
  
 
  private
    def normalize_name
      self.name = name.downcase.titleize
    end
end
