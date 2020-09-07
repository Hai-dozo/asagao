class MembersController < ApplicationController
    before_action :login_required

    # 会員一覧
    def index
        @members = Member.order("number") # numberを昇順で表示
            .page(params[:page]).per(10)
    end

    def search
        @members = Member.search(params[:q])
            .page(params[:page]).per(10)
        render "index"
    end

    def show
        @member = Member.find(params[:id])
    end

    def new
        @member = Member.new(birthday: Date.new(1980, 1, 1)) # 誕生日の初期値を指定する
    end

    def edit
        @member = Member.find(params[:id])
    end

    def create
        @member = Member.new(params[:member])
        if @member.save
            redirect_to @member, notice: "会員を登録しました。"
        else
            render "new"
        end
    end

    def update
        @member = Member.find(params[:id])
        @member.assign_attributes(params[:member])
        if @member.save
            redirect_to @member, notice: "会員情報を更新しました"
        else
            render "edit"
        end
    end

    def destroy
        @member = Member.find(params[:id])
        @member.destroy
        redirect_to :members, notice: "会員を削除しました"
    end
end
