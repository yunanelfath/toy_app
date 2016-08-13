class FeedsController < ApplicationController
  def index
    json_file = File.open(File.join(Rails.root, 'lib','assets','feeds.json'))
    file = File.read(json_file)

    @default_limit = 3

    @file = JSON.parse(file)
    offset = params[:page].nil? ? 0 : params[:page].to_i
    limit = params[:limit].nil? ? @default_limit : params[:limit].to_i

    offset = limit * offset
    @file = @file["feeds"][offset,limit]

    if params[:format] == "js"
      render :json => @file
    end

  end
end
