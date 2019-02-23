class CreateIdentifications < ActiveRecord::Migration
  def change
    create_table :identifications do |t|
      t.string :firstname
      t.string :lastname
      t.text :date_of_birth
      t.string :country_of_birth
      t.string :nationality
      t.string :sex
      t.string :address
      t.text :issued_date
      t.text :expiry_date
      
     t.timestamps null: false
    end
  end
end
