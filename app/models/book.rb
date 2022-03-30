class Book < ApplicationRecord
  belongs_to :user, counter_cache: true, touch: true
  
  before_validation :capitalizeTitle, on: [ :create, :update ]
  after_validation :capitalizeTitle, on: [ :create, :update ]
  
  before_save :findUser, if: Proc.new {
    puts "Hello hello #{self.user_id}"
    raise 'You can\'t add more then 5 books' if User.find(self.user_id).books.count > 5
  }
  after_rollback :findUser , on: [ :create, :update ]
  after_commit :findUser, on: [ :create, :update ]
  
  after_save :findUserData 
  
  before_destroy :sendMsgToUser
  after_destroy :sendMsgToUser1
  
  after_initialize do
    puts "You have initialized an object!"
  end

  after_find do
    puts "You have found an object!"
  end
  
  private
  
  def capitalizeTitle
    if title.capitalize != title
      puts "Name must be capitalize so had do for you" 
      self.title = title.capitalize
    else 
      puts "Great your title is capitalized"
    end
    
  end
  
  
  def findUser
    user = User.exists?(self.user_id)
    if user
      puts "User found Successfully "
    else 
      puts "We are sorry.... User can't find :("
    end
  end
  
  def findUserData
    user = User.find(self.user_id) 
    puts user.name
  end
  
  def sendMsgToUser
    user = User.find(user_id)
    puts "Hello, #{user.name} your book #{title} is going to delete"
  end
  
  def sendMsgToUser1
    user = User.find(user_id)
    puts "Hello, #{user.name} your book #{title} was now deleted"
  end
end
