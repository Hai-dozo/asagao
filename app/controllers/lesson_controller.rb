class LessonController < ApplicationController
    def step1
        render plain: "こんにちは、#{params[:name]}さん"
    end

    def step2
        render plain: params[:controller] + "#" + params[:action]
    end

    def step3
        redirect_to action: "step4"
    end

    def step4
        render plain: "step4に移動しました"
    end

    def step5
        flash[:notice] = "step6に移動します"
        redirect_to action: "step6"
    end

    def step6
        render plain: flash[:notice]
    end

    def step7
        @price = "<script>alert('危険')</script> こんにちは"
    end

    def step11
        @population = 704414
        @surface = 141.31
        @time = Time.current
        @number = 123456789
    end

    def step17
        @zaiko = 10
        @items = {"フライパン" => 2680, "ワイングラス" => 2550,
                  "ペッパーミール" => 4515, "ピーラー" => 945}
    end
end