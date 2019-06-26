class PlaysController < ApplicationController
  def index
    @random_images = Upload.random.limit(10)
    @plays = Play.all.order('id DESC')
  end

  def create
    @play = Play.new(play_params)

    unless @play.save
      render json: { status: :unprocessable_entity }
    end
  end

private

  def play_params
    params.require(:play).permit(:upload_id, :timer)
  end
end
