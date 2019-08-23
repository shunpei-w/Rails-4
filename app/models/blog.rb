class Blog < ApplicationRecord
    default_scope -> { order(created_at: :id) }
end
