class Transaction < ApplicationRecord
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :amount, presence: true
  belongs_to :sender,
    primary_key: :id,
    foreign_key: :sender_id,
    class_name: :User
  belongs_to :receiver,
    primary_key: :id,
    foreign_key: :receiver_id,
    class_name: :User
end
