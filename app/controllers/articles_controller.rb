class ArticlesController < ApplicationController
    before_action :login_required, except: [:index, :show]

    # 記事一覧
    def index
        @articles = Article.order(released_at: :desc)
        @articles = @articles.open_to_the_public unless current_member

        unless current_member&.administrator?
            @articles = @articles.visible
        end
    end

    # 記事詳細
    def show
        articles = Article.all
        articles = article.open_to_the_public unless current_member

        unless current_member&.administrator?
            articles = articles.visible
        end

        @article = articles.find(params[:id])
    end


    def new
        @article = Article.new
    end

    # 記事編集
    def edit
        @article = Article.find(params[:id])
    end

    # 記事作成
    def create
        @article = Article.new(params[:article])
        if @article.save
            redirect_to @article, notice: "ニュース記事を登録しました"
        else
            render "new"
        end
    end

    def update
        @article = Article.find(params[:id])
        @article.assign_attributes(params[:article])
        if @article.save
            redirect_to @article, notice: "ニュース記事を更新しました。"
        else
            render "edit"
        end
        
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to :articles
    end

end
