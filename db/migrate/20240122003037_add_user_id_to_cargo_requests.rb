class AddUserIdToCargoRequests < ActiveRecord::Migration[7.0]
  def change
    add_reference :cargo_requests, :user, null: false, foreign_key: { on_delete: :cascade }
  end
end
