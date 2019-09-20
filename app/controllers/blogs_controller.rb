class BlogsController < ApplicationController
  layout "blogs"
  impressionist :actions=> [:show]
  
  def index
    page_size = 5
    @page_num = 0
    if params[:page] != nil then
      @page_num = params[:page].to_i
    end
    @data = Blogpost.all
        .offset(page_size * @page_num)
        .limit(page_size)
    @blogconfig = Blogconfig.find 1

    if params[:id] == "古い順"
      @data = Blogpost.all.order("created_at asc")
    else
      @data = Blogpost.all.order("created_at desc")
    end


    @search = Array.new
    if request.post? then
      @search = Blogpost.where title: params[:find]
    end    
    logger.debug("indexを通る")
  
  end

  def genre
    page_size = 5
    @page_num = 0
    if params[:page] != nil then
        @page_num = params[:page].to_i
    end
    @genre = Bloggenre.find params[:id]
    @data = Blogpost.where("bloggenre_id = ?", params[:id])
        .order("created_at desc").offset(page_size * @page_num)
        .limit(page_size)
    @blogconfig = Blogconfig.find 1
  end

  def show
    @blogpost = Blogpost.find params[:id]
    @blogconfig = Blogconfig.find 1
    @tweet = Blogpost.find(params[:id])
    impressionist(@tweet, nil, :unique => [:session_hash])
  end

  def find

    logger.debug("params")
    
    @search = Array.new
    if request.post? then
      obj = Blogpost.find params["find"]
      @search.push obj
    end
  end
end