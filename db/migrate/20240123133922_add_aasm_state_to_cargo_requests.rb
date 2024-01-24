class AddAasmStateToCargoRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :cargo_requests, :aasm_state, :string
  end
end
