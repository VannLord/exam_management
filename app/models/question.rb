# == Schema Information
#
# Table name: questions
#
#  id          :bigint           not null, primary key
#  choice_type :integer
#  content     :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  subject_id  :bigint           not null
#
# Indexes
#
#  index_questions_on_subject_id  (subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (subject_id => subjects.id)
#
class Question < ApplicationRecord
  belongs_to :subject
  has_many :answers, dependent: :destroy
  has_many :exam_questions, dependent: :destroy
  enum choice_type: {single: 1, multiple: 2}
  scope :sort_by_created_at_desc, ->{order(created_at: :desc)}
  validates :content, presence: true,
            length: {maximum: Settings.question.content.max_length}
  validates :choice_type, presence: true
end
