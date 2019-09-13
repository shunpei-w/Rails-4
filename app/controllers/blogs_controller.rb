class BlogsController < ApplicationController
  layout "blogs"
  
  def index
    page_size = 5
    @page_num = 0
    if params[:page] != nil then
      @page_num = params[:page].to_i
    end
    @data = Blogpost.all.order(params[:sort])
        .offset(page_size * @page_num)
        .limit(page_size)
    @blogconfig = Blogconfig.find 1

    @search = Array.new
    if request.post? then
      @search = Blogpost.where title: params[:find]
    end

    logger.debug("if文の中に入りました")


  def search
      @abcs = Abc.where('year LIKE ?', "%#{params[:year]}%")
      @year = Abc.group(:year).pluck(:year).sort　#ここを追加！
      render :index
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