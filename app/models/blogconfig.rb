class Blogconfig < ApplicationRecord
    validates :title,:stylename,presence: {message:"は、必須項目です。"}
end
