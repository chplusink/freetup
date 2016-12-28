class CreateMeetupRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :meetup_requests do |t|
      t.string :zip
      t.string :topic
    end
  end
end
