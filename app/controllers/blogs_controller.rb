class BlogsController < ApplicationController
  layout "blogs"
  impressionist
  
  def index

    page_size = 5
    @page_num = 0
    if params[:page] != nil then
      @page_num = params[:page].to_i
    end
    # @data = Blogpost.all.order(count: "desc")
    #     .offset(page_size * @page_num)
    #     .limit(page_size)

    @data = Blogpost.all.order(count: "desc")
    @data.each do |obj|
      logger.debug(obj.count)
    end


    @blogconfig = Blogconfig.find 1



    if params[:id] == "新しい順"
      @data = Blogpost.all.order(id: "desc")
      logger.debug("新しい順ここを通る")

    elsif params[:id] == "古い順"
      @data = Blogpost.all.order(id: "asc")
      logger.debug("古い順ここを通る")
      

    else
      @data = Blogpost.all.order(count: "desc")
      @data.each do |obj|
        logger.debug(obj.id)
      end
      logger.debug("閲覧数ここを通る")
    end


    @search = Array.new
    if request.post? then
      @search = Blogpost.where title: params[:find]
    end    
  
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

    @blogpost.count += 1
    @blogpost.save
  end
end