# == Schema Information
#
# Table name: exam_questions
#
#  id          :bigint           not null, primary key
#  score       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  exam_id     :bigint           not null
#  question_id :bigint           not null
#
# Indexes
#
#  index_exam_questions_on_exam_id      (exam_id)
#  index_exam_questions_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (exam_id => exams.id)
#  fk_rails_...  (question_id => questions.id)
#
class ExamQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :exam
  has_many :answers, through: :question
end
