class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :body
      t.string :release_date
      t.string :rating
      t.string :director

      t.timestamps
    end
  end
end
