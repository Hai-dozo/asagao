class Article < ApplicationRecord
    validates :title, :body, :released_at, presence: true
    validates :title, length: {maximum: 80}
    validates :body, length: {maximum: 2000}

    def no_expiration
        expired_at.nil?
    end

    def no_expiration=(val)
        # 引数がtrueか1だった場合は@no_expirationをtrueにし、そうでなければfalseにする。
        # ブラウザはフォームにチェックがついてなければ0を、ついてれば1を送ってくる。
        @no_expiration = val.in?([true, "1"]) 
    end

    before_validation do
        self.expired_at = nil if @no_expiration
    end

    validate do
        if expired_at && expired_at < released_at
            errors.add(:expired_at, :expired_at_too_old)
        end
    end

    scope :open_to_the_public, -> { where(member_only: false) }
    
    scope :visible, -> do
        now = Time.current
        where("released_at <= ?", now) # 公開日がnowかnowより前（以下）
            .where("expired_at > ? OR expired_at IS NULL", now) # expired_atがnowより先（より大きい）
    end

end
