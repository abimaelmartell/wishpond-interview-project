class Play < ApplicationRecord
  belongs_to :upload

  validates_presence_of :upload
  validates_presence_of :timer
end
