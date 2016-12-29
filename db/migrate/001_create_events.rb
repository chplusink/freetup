class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.string :link
      t.string :group
      t.string :group_slug
      t.string :date_time
    end
  end
end
