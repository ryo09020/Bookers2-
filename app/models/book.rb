class Book < ApplicationRecord
   has_one_attached :image
   belongs_to :user
   has_many :book_comments, dependent: :destroy
   has_many :favorites, dependent: :destroy
   
   
   validates :title, presence: true
   validates :body, length: { minimum: 1, maximum: 200 }
   
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
  
  def get_image(width, height)
   unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_book.png')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
end 
