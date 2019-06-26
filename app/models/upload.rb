class Upload < ApplicationRecord
  has_one_attached :file

  has_many :plays, dependent: :destroy

  scope :random, -> { order(Arel.sql("RANDOM()")) }

  validate :validate_uploaded_file, if: -> { file.attached? }

  def validate_uploaded_file
    unless file.blob.byte_size < 2000000
      errors[:file] << "can't be bigger than 2MB"
    end

    unless file.blob.image?
      errors[:file] << "can only be image"
    end
  end
end
