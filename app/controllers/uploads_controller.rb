class UploadsController < ApplicationController
  before_action :find_upload, only: :destroy

  def index
    @uploads = Upload.all.with_attached_file
    @upload = Upload.new
  end

  def create
    upload_files_params.each do |file|
      upload = Upload.new
      upload.file.attach(file)

      unless upload.save
        flash[:error] = upload.errors.full_messages.join(", ")

        return redirect_to uploads_path
      end
    end

    flash[:notice] = "Files uploaded succesfully."

    redirect_to uploads_path
  end

  def destroy
    if @upload.destroy
      flash[:notice] = "Upload removed succesfully."
    end

    redirect_to uploads_path
  end

private

  def upload_files_params
    params.require(:upload).require(:file)
  end

  def find_upload
    @upload = Upload.find(params[:id])
  end
end
