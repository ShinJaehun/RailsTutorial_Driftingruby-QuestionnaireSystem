class CreateResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :responses do |t|
      t.belongs_to :questionnaire, null: false, foreign_key: true
      t.belongs_to :question, null: false, foreign_key: true
      t.text :response_text

      t.timestamps
    end
  end
end
