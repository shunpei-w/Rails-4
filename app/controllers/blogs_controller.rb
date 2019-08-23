class BlogsController < ApplicationController
  layout "blogs"
  before_action :set_variable, only: [:index, :sort]

  

  def sort
    if params[:created_at].present?
      @created_at_num = params[:created_at].to_i

      if @created_at_num == 0
        @data = Blogpost.order(created_at: :DESC)
        @created_at = '登録日時▼'
        @created_at_num = 1
      else
        @data = Blogpost.order(created_at: :ASC)
        @created_at = '登録日時▲'
        @created_at_num = 0
      end

    else
      @books = Blogpost.all
    end
    render :index
  end

  private

  def set_variable
    @created_at = '登録日時△'
    @updated_at = '更新日時△'
    @created_at_num = 0
    @updated_at_num = 0
  end



  
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
    
    @data = Array.new
    if request.post? then
      @data = Blogpost.where title: params[:find]
    end
  end

end
