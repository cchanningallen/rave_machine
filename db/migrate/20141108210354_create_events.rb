class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :name
      t.date :date
      t.text :time
      t.text :artists, array: true
      t.text :location
      t.text :description
      t.text :event_link
      t.text :ticket_link
      t.text :price
      t.text :age_limit

      t.timestamps
    end
  end
end
