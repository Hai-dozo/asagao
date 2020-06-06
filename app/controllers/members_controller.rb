class MembersController < ApplicationController
    before_action :login_required

    # 会員一覧
    def index
        @members = Member.order("number") # numberを昇順で表示
    end

    def search
        @members = Member.search(params[:q])
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
    end

    def destroy
    end
end
