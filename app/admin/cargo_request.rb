ActiveAdmin.register CargoRequest do
  permit_params :first_name, :last_name, :middle_name, :phone, :email, :weight, :length, :width, :height, :departure_point, :destination, :distance, :price, :aasm_state

  action_item :approve, only: :show do
    if cargo_request.rejected? || cargo_request.pending?
      link_to "Утвердить", approve_cargo_request_path(cargo_request), method: :put
    end
  end

  action_item :reject, only: :show do
    if cargo_request.approved? || cargo_request.pending?
      link_to "Отклонить", reject_cargo_request_path(cargo_request), method: :put
    end
  end

  action_item :reset_to_pending, only: :show do
    link_to "В ожидание", reset_to_pending_cargo_request_path(cargo_request), method: :put if cargo_request.approved? || cargo_request.rejected?
  end
end
