class Post < ApplicationRecord
  include Filterable

  belongs_to :author

  validates :body, presence: true
  validates :title, presence: true

  scope :filter_by_q, -> (query) { where("title ILIKE ? OR body ILIKE ?", "%#{query}%", "%#{query}%") }
  scope :filter_by_author, -> (author_id) { where author_id: author_id }
  scope :filter_by_order_by, -> (order_option) { order("#{order_option} DESC")}

  def inc_visit_count()
    self.visit_count += 1
    self.save
  end
end
