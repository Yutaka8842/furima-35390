class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :params_id, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :sold_move_to_index, only: [:edit, :update, :destroy]
  before_action :search_object, only: [:search_page, :item_search]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item_tag_form = ItemTagForm.new
  end

  def create
    @item_tag_form = ItemTagForm.new(item_params)
    if @item_tag_form.valid?
      @item_tag_form.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def tag_search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  def search_page

  end

  def item_search
    @results = @p.result
  end

  private

  def params_id
    @item = Item.find(params[:id])
  end

  def search_object
    @p = Item.ransack(params[:q])  # 検索オブジェクトを生成
  end

  def item_params
    params.require(:item_tag_form).permit(:name, :item_name, :item_description, :item_category_id, :item_status_id, :delivery_charge_id, :prefectures_id, :shipping_days_id, :selling_price, images: []).merge(user_id: current_user.id)
  end

  def move_to_index
    unless current_user.id == @item.user.id
      redirect_to action: :index
    end
  end

  def sold_move_to_index
    if @item.order.present?
      redirect_to action: :index
    end
  end
end
