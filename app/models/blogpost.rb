class Blogpost < ApplicationRecord
    belongs_to :bloggenre

    validates :title, :content, presence: {message:"は、必須項目です。"}
    default_scope -> { order(created_at: :desc) }

end
