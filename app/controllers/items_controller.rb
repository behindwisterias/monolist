class ItemsController < ApplicationController
  before_action :logged_in_user , except: [:show]
  before_action :set_item, only: [:show]

  def new #「アイテム追加画面」でAPIの結果を用いて商品一覧
    if params[:q] #検索ワード(name=q)を指定
      response = Amazon::Ecs.item_search(params[:q] , 
                                  :search_index => 'All' , 
                                  :response_group => 'Medium' , 
                                  :country => 'jp')
      @amazon_items = response.items #@amazon_itemsという変数に商品検索結果を渡す
    end
  end

  def show
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
end
