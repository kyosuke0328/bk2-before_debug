class BooksController < ApplicationController
    before_action :authenticate_user!
  def new
    @book = Book.new
    end
    def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
      if @book.save
          flash[:notice] = "Book was successfully created."
          redirect_to book_path(@book.id)
        else
            @user = current_user
          @books = Book.all
          render 'index'
        end
    end
    def index
      @book = Book.new
    @books = Book.all
        @user = current_user
    end
    def show
        @new_book = Book.new
      @book = Book.find(params[:id])
        @user = @book.user
    end
    def edit
      @book = Book.find(params[:id])
        if @book.user.id != current_user.id
           redirect_to books_path
            
        end
    end
    def destroy
      book = Book.find(params[:id])
        book.destroy
      redirect_to books_path
    end
    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
          flash[:notice] = "Book was successfully created."
          redirect_to book_path(@book)
        else
          render 'edit'
        end
    end

    private
    def book_params
        params.require(:book).permit(:title, :body )
    end
end
