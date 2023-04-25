require_relative './magi_unit'

class AggregateUnit < MagiUnit
  def question_content(content)
    question_content = <<~"EOS"
    あなたはファシリテーションのプロ
    #{@answer_tokens}文字以内で意見の集約をして具体的な解決策を提案すること
    なお、表題はつけず集約結果のみ回答すること
    #{content}
    EOS
    question_content
  end
end