class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    before_action :authenticate_user!, only: [:edit, :update, :destroy]

    def set_article
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def create
        # render plain: params[:article].inspect
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:success] = "Article was successfully created"
            redirect_to @article
        else
            render 'new'
        end
    end

    def show
        # @article = Article.find(params[:id])
    end

    def edit
        # @article = Article.find(params[:id])
    end

    def update
        # @article = Article.find(params[:id])
        if @article.user_id == current_user.id
            if @article.update(article_params)
                flash[:success] = "Article was updated"
                redirect_to @article
            else
                flash[:warning] = "Article was not updated"
                render 'edit'
            end
        else
            flash[:warning] = "Not your article bro!"
            redirect_to @article
        end
    end

    def destroy
        # @article = Article.find(params[:id])
        if @article.user_id == current_user.id
            @article.destroy
            flash[:success] = "Article was deleted"
            redirect_to articles_path
        else
            flash[:warning] = "Not your article bro!"
            redirect_to @article
        end
    end

    private

    def article_params
        params.require(:article).permit(:title, :description)
    end
end
