class Book < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }
  validates :author, presence: true, length: { minimum: 5 }
  validates :publisher, presence: true
  validates :genre, presence: true, length: { minimum: 5 }
end
