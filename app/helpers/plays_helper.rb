module PlaysHelper
  def generate_uploads_json(uploads)
    json = []

    uploads.each do |upload|
      json << {
        id: upload.id,
        url: url_for(upload.file)
      }
    end

    json
  end
end
