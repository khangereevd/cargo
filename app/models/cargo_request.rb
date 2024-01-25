class CargoRequest < ApplicationRecord
  include AASM

  belongs_to :user

  paginates_per 10

  validates :first_name, :last_name, :middle_name, :phone, :email, :weight, :length, :width, :height, :departure_point, :destination, :distance, :price, presence: true

  def self.ransackable_attributes(auth_object = nil)
    super + ['aasm_state']
  end

  def self.ransackable_associations(_auth_object = nil)
    super()
  end

  aasm do
    state :pending, initial: true
    state :approved
    state :rejected

    event :approve do
      transitions from: [:pending, :rejected], to: :approved
    end

    event :reject do
      transitions from: [:pending, :approved], to: :rejected
    end

    event :reset_to_pending do
      transitions from: [:approved, :rejected], to: :pending
    end
  end
end
