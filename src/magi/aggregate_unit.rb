require_relative './magi_unit'

class AggregateUnit < MagiUnit
  def question_content(content)
    question_content = <<~"EOS"
    # 命令文
    あなたはファシリテーションのプロです
    以下の制約条件と入力分を元に、意見を集約して具体的な解決策を提案してください。

    # 制約条件
    ・#{@answer_tokens}文字以内で回答すること
    ・集約した結果のみを回答すること

    # 入力文
    #{content}

    # 出力文
    EOS
    question_content
  end
end