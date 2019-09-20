class Blogpost < ApplicationRecord
    is_impressionable

    belongs_to :bloggenre

    validates :title, :content, presence: {message:"は、必須項目です。"}

end
