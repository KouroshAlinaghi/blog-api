class CreateAuths < ActiveRecord::Migration[6.0]
  def change
    create_table :auths do |t|
      t.string :code, null: false
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
