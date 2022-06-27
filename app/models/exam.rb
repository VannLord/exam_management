# == Schema Information
#
# Table name: exams
#
#  id                     :bigint           not null, primary key
#  name                   :string(255)
#  time                   :integer
#  total_number_questions :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  subject_id             :bigint           not null
#
# Indexes
#
#  index_exams_on_subject_id  (subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (subject_id => subjects.id)
#
class Exam < ApplicationRecord
  belongs_to :subject
  scope :sort_by_created_at_desc, ->{order(created_at: :desc)}
  has_many :exam_questions, dependent: :destroy
  has_many :questions, through: :exam_questions
  has_many :user_exams, dependent: :destroy
  scope :questions_sort_by_created_at_asc, (lambda do |exam|
    exam.questions.order(created_at: :asc)
  end)
  delegate :name, to: :subject, prefix: true
end
