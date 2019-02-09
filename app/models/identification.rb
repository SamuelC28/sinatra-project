class Identification < ActiveRecord::Base
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :date_of_birth, presence: true
  validates :country_of_birth, presence: true
  validates :nationality, presence: true
  validates :sex, presence: true
  validates :address, presence: true
  # validates :expiry_date, presence: true
  
  belongs_to :user
  
  alias_attribute :issued_date, :created_at

  # after_create do 
  #   self.expiry_date = issued_date + (365 * 5)
  # end

  def self.expiry_date
    issued_date + (365 * 5)
  end

  def count_by_user
    self.count
  end
end
