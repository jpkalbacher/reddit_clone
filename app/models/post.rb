class Post < ActiveRecord::Base
  validates :title, :sub_id, :author_id, presence: true

  has_many :cross_posts
  has_many :extra_subs,
    through: :cross_posts,
    source: :subs

  belongs_to :sub
  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
end
