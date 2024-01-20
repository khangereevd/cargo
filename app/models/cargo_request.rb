class CargoRequest < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "departure_point", "destination", "distance", "email", "first_name", "height", "id", "last_name", "length", "middle_name", "phone", "price", "updated_at", "weight", "width"]
  end
  validates :first_name, :last_name, :middle_name, :phone, :email, :weight, :length, :width, :height, :departure_point, :destination, :distance, :price, presence: true
end
