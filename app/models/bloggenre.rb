class Bloggenre < ApplicationRecord
    has_many :blogpost

    validates :name,presence: {message:"は、必須項目です。"}
end