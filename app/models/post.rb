class Post < ApplicationRecord
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :memo, length: { maximum: 500 }
  validates :title, presence: true, length: { maximum: 50 }
  
  #「ｓ」を取り忘れていた
  validate :not_before_today
  
  def not_before_today
    return if end_at.blank?
    errors.add(:end_at, "は今日以降の日付を選択してください") if end_at < Date.today
  end
end
