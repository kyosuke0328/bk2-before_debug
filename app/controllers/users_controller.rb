class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:index, :show, :edit]
    def new
    @user = user.new
    end
    def create
      @user = User.new(user_params)
      @user.user_id = current_user.id
        if  @user.save
            flash[:notice] = "Book was successfully created."
          redirect_to users_path
        else
            @user = current_user
            @users = Book.all
            flash[:notice] = "error"
            render 'index'
        end
    end
    def index
        @book = Book.new
        @users = User.all
        @user = current_user
    end
    def show
      @new_book = Book.new
        @user = User.find(params[:id])
        @books = @user.books
    end
    def edit
      @user = User.find(params[:id])
        if @user.id != current_user.id
           redirect_to user_path(current_user)
            
        end
    end
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice] = "User was successfully created."
            redirect_to user_path(@user)
        else
            render 'edit'
        end
    end

    private
    def user_params
        params.require(:user).permit(:name, :introduction, :profile_image )
    end
end

