class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        validates :name, presence: true, length: { in: 2..20 }
        validates :introduction, length: { maximum: 50 }

         has_many :books, dependent: :destroy
         has_many :homes, dependent: :destroy
         attachment :profile_image # ここを追加（_idは含めません）
         def email_required?
            false
  		 end

  	     def email_changed?
            false
         end
end
