class Comment < ApplicationRecord
  validates :content, :user_id, :post_id, presence: true

  belongs_to(:parent_comment,
    foreign_key: :parent_id,
    primary_key: :id,
    class_name: 'Comment',
    optional: true
  )

  belongs_to(:post,
    foreign_key: :post_id,
    primary_key: :id,
    class_name: 'Post'
  )

  has_one(:sub,
    through: :post,
    source: :sub
  )

  belongs_to(:author,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'User'
  )

  has_many(:child_comments,
    foreign_key: :parent_id,
    primary_key: :id,
    class_name: 'Comment'
  )
end
