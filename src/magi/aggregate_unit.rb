require_relative './magi_unit'

class AggregateUnit < MagiUnit
  def question_content(content)
    question_content = <<~"EOS"
    あなたは意見集約のプロです
    20文字以内で意見の集約をしてください
    #{content}
    EOS
    question_content
  end
end