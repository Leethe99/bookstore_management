class BooksController < ApplicationController
    def index
      @books = Book.all
      @inventory = Inventory.all
      @stores = Store.all
    end
  
    def show
      @book = Book.find(params[:id])
    end
  
    def new
      @book = Book.new
    end
  
    def create
      @book = Book.new(book_params)
      if @book.save
        redirect_to book_path(@book), notice: 'Book created successfully!'
      else
        render :new
      end
    end
  
    def edit
      @book = Book.find(params[:id])
    end
  
    def update
      @book = Book.find(params[:id])
      if @book.update(book_params)
        redirect_to book_path(@book), notice: 'Book updated successfully!'
      else
        render :edit
      end
    end
  
    def destroy
      @book = Book.find(params[:id])
      @book.destroy
      redirect_to books_path, notice: 'Book deleted successfully!'
    end
    
    def assign
      @book = Book.find(params[:id])
      @stores = Store.all
      @inventory = Inventory.all
    end
  
    def update_assignment
    @book = Book.find(params[:id])
    store_id = params[:store_id]
    quantity = params[:quantity].to_i

    if store_id.present? && quantity > 0
      @store = Store.find_by(id: store_id)
      if @store
        inventory = @store.inventories.find_or_initialize_by(book_id: @book.id)
        inventory.quantity = quantity
        inventory.save
        redirect_to @book, notice: 'Book assignment updated successfully!'
      else
        redirect_to @book, alert: 'Invalid store.'
      end
    else
      redirect_to @book, alert: 'Invalid assignment.'
    end
  end

    private
  
    def book_params
      params.require(:book).permit(:title, :author, :year)
    end
  end
  