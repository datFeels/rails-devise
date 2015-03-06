class Post < ActiveRecord::Base
    default_scope -> { order(created_at: :desc) }
    belongs_to :user
    validates :content, presence: true, length: { maximum: 300 }
    has_many :post_attachments
    accepts_nested_attributes_for :post_attachments
    acts_as_likeable
end

