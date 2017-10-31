class Sub < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: true

  has_many :postsubs, dependent: :destroy, inverse_of: :sub
  has_many :posts, through: :postsubs

  # has_many(:posts,
  #   foreign_key: :sub_id,
  #   primary_key: :id,
  #   class_name: 'Post'
  # )

  has_many(:moderator_memberships,
    foreign_key: :sub_id,
    primary_key: :id,
    class_name: 'Moderator'
  )

  has_many(:moderators,
    through: :moderator_memberships,
    source: :moderator
  )

  def is_moderator?(user)
    if self.moderators.include?(user)
      true
    else
      false
    end
  end

end
