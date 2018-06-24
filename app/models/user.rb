class User < ApplicationRecord
    # Using bcrypt
    has_secure_password

    # has many todos using the created_by field as foreign key
    has_many :todos, foreign_key: :created_by

    # Validations
    validates_presence_of :name, :email, :password_digest
end
