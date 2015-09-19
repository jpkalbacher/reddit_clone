class CrossPost < ActiveRecord::Base
  belongs_to :post
  belongs_to :sub

  validate :cant_cross_post_to_self

  def cant_cross_post_to_self
    post = Post.find(self.post_id)
    if post.sub_id == self.sub_id
      errors[:self] << "Cannot be cross-posted to subreddit where post is created."
    end
  end
end
