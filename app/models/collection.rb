class Collection < ActiveRecord::Base
  attr_accessible :card_id, :user_id, :quantity

  belongs_to :card
  belongs_to :user

  validates_presence_of :card_id

  validates_presence_of :user_id

  validates_presence_of     :quantity
  validates_numericality_of :quantity, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 2147483647

  after_initialize do
    if self.new_record?
      self.quantity ||= 0
    end
  end
end
