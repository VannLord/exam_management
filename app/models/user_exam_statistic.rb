# == Schema Information
#
# Table name: user_exam_statistics
#
#  id               :bigint           not null, primary key
#  date             :datetime
#  total_done_exams :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class UserExamStatistic < ApplicationRecord
  has_many :user_exam_statistic_details, dependent: :destroy
  scope :statistic_on_date, ->(date){where "date(date) = date(?)", date}
end
