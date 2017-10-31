class Moderator < ApplicationRecord
  validates :user_id, :sub_id, presence: true
  validates :user_id, uniqueness: {scope: :sub_id }


  belongs_to(:sub,
    foreign_key: :sub_id,
    primary_key: :id,
    class_name: 'Sub'
  )

  belongs_to(:moderator,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'User'
  )
end
