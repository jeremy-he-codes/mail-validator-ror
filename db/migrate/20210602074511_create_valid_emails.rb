class CreateValidEmails < ActiveRecord::Migration[6.1]
  def change
    create_table :valid_emails do |t|
      t.string :email, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
