class User < ApplicationRecord
  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimun: 3, manimun: 25}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/iv
    validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 105}, format: {with: VALID_EMAIL_REGEX}
end
