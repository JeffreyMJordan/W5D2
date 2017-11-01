class Post < ApplicationRecord
  validates :title, :user_id, :sub_id, presence: true

  has_many :postsubs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :postsubs

  belongs_to(:author,
  foreign_key: :user_id,
  primary_key: :id,
  class_name: 'User')

  belongs_to(:sub,
  foreign_key: :sub_id,
  primary_key: :id,
  class_name: 'Sub')

  has_many(:comments,
    foreign_key: :post_id,
    primary_key: :id,
    class_name: 'Comment'
  )

  def top_comments
    comments.where(parent_id: nil)
  end


end
