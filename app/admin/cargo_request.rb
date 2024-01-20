ActiveAdmin.register CargoRequest do
  permit_params :first_name, :last_name, :middle_name, :phone, :email, :weight, :length, :width, :height, :departure_point, :destination, :distance, :price
end
