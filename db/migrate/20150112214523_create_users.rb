class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :name
      t.string    :email
      t.string    :nickname
      t.string    :image_url
      t.string    :gh_uid,  null: false
      t.timestamps
    end
  end
end