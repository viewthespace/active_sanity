class InvalidRecord < ActiveRecord::Base
  belongs_to :record, polymorphic: true
  serialize :validation_errors

  validates :record, presence: true
  validates :record_id, presence: true, uniqueness: { scope: :record_type }
end
