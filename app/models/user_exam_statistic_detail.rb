# == Schema Information
#
# Table name: user_exam_statistic_details
#
#  id                     :bigint           not null, primary key
#  count                  :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  subject_id             :bigint           not null
#  user_exam_statistic_id :bigint           not null
#
# Indexes
#
#  index_user_exam_statistic_details_on_subject_id              (subject_id)
#  index_user_exam_statistic_details_on_user_exam_statistic_id  (user_exam_statistic_id)
#
# Foreign Keys
#
#  fk_rails_...  (subject_id => subjects.id)
#  fk_rails_...  (user_exam_statistic_id => user_exam_statistics.id)
#
class UserExamStatisticDetail < ApplicationRecord
  belongs_to :user_exam_statistic
  belongs_to :subject
  delegate :name, to: :subject, prefix: true
end
