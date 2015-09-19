class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :author,
    class_name: 'User',
    foreign_key: :author_id

  belongs_to :parent,
    class_name: 'Comment',
    foreign_key: :parent_comment_id

  has_many :children,
    class_name: 'Comment',
    foreign_key: :parent_comment_id

end
