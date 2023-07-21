class StoresController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
    def index
      @stores = Store.all
    end
  
    def show
      @store = Store.find(params[:id])
    end
  
    def new
      @store = Store.new
    end
  
    def create
      @store = Store.new(store_params)
      if @store.save
        redirect_to store_path(@store)
      else
        render :new
      end
    end
  
    def edit
      @store = Store.find(params[:id])
    end
  
    def update
      @store = Store.find(params[:id])
      if @store.update(store_params)
        redirect_to store_path(@store)
      else
        render :edit
      end
    end
  
    def destroy
      @store = Store.find(params[:id])
      @store.inventories.destroy_all
      @store.destroy
      redirect_to stores_path
    end
  
    private
  
    def store_params
      params.require(:store).permit(:codename, :address, :phone)
    end
  end
  