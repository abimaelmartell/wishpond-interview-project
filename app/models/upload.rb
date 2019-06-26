class Upload < ApplicationRecord
  has_one_attached :file

  validate :validate_uploaded_file, if: -> { file.attached? }

  def validate_uploaded_file
    unless file.blob.byte_size < 2000000
      errors[:file] << "Cant be bigger than 2MB"
    end

    unless file.blob.image?
      errors[:file] << "Can only be image"
    end
  end
end