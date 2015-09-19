class Sub < ActiveRecord::Base
  validates :title, uniqueness: true

  belongs_to :moderator,
    class_name: "User",
    foreign_key: :moderator_id,
    primary_key: :id

  has_many :posts
  has_many :cross_posts
  has_many :extra_posts,
    through: :cross_posts,
    source: :posts
end
