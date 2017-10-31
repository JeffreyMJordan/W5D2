class Postsub < ApplicationRecord
  validates :post, :sub, presence: true
  
  belongs_to :post
  belongs_to :sub

end
