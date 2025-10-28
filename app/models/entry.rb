class Entry < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :title, presence: true, length: { minimum: 1, maximum: 200 }
  validates :content, presence: true, length: { minimum: 1, maximum: 10000 }
end
