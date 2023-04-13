

class Book < ActiveRecord::Base
    belongs_to :category
  
    validates :title, :author, presence: true
  
    def category_name
      category&.name
    end
  
    def category_name=(name)
      self.category = Category.find_or_create_by(name: name) if name.present?
    end
  end
  