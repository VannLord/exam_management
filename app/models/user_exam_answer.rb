# == Schema Information
#
# Table name: user_exam_answers
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_answer_id :bigint           not null
#  user_exam_id   :bigint           not null
#
# Indexes
#
#  index_user_exam_answers_on_user_answer_id  (user_answer_id)
#  index_user_exam_answers_on_user_exam_id    (user_exam_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_answer_id => answers.id)
#  fk_rails_...  (user_exam_id => user_exams.id)
#
class UserExamAnswer < ApplicationRecord
  belongs_to :answer, class_name: Answer.name, foreign_key: :user_answer_id
  belongs_to :user_exam
  delegate :correct, to: :answer
end
