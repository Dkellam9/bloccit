class AddTopicsToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :topic, index: true
  end
end
