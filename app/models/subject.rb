# == Schema Information
#
# Table name: subjects
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Subject < ApplicationRecord
  scope :sort_by_created_at_desc, ->{order(created_at: :desc)}
  has_many :exams, dependent: :destroy
  has_many :user_exams, through: :exams
  has_many :questions, dependent: :destroy
  validates :name, presence: true
end
