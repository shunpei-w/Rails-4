class AddCountToBlogpost < ActiveRecord::Migration[5.2]
  def change
    add_column :blogposts, :count, :integer
  end
end
