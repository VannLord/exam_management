module Trainee::UserExamsHelper
  def convert_num_to_time spent_time
    h = spent_time / 3600
    spent_time %= 3600
    m = spent_time / 60
    s = spent_time % 60
    %(#{two_number(h)}:#{two_number(m)}:#{two_number(s)})
  end

  def subject_options subjects
    subjects.map{|u| [u.name, u.id]}
  end

  def class_for_user_exam_status user_exam
    return "label label-primary" if user_exam.start?
    return "label label-info" if user_exam.unchecked?
    return "label label-success" if user_exam.checked?

    "label label-danger"
  end

  def class_for_answer user_answer_ids, answer
    return unless user_answer_ids.include?(answer.id)
    return "correct" if answer.correct

    "uncorrect"
  end

  private

  def two_number num
    (0..9).include?(num) ? %(0#{num}) : num
  end
end
