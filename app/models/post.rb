class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validate :url_in_right_format
  validate :post_sub_not_empty

  belongs_to :author,
    foreign_key: :author_id,
    class_name: :User

  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs
  has_many :comments, dependent: :destroy


  def url_in_right_format
    return if self.url.nil?
    unless self.url[0..6] == "http://"
      errors[:url] << "must start with http://"
    end
  end

  def post_sub_not_empty
    errors[:base] << "Post must belong to at least one sub" if self.subs == []
  end

  def master_comments
    self.comments.where("parent_comment_id IS NULL")
  end
end
