require_relative './magi_unit'

class AnswerUnit < MagiUnit
  attr_reader :character
  alias :super_to_s_question_answer :to_s_question_answer

  def initialize(character)
    @character = character
    super()
  end

  def question_content(content)
    <<~"EOS"
    # 命令文
    #{@answer_tokens}文字以内で人格に沿って入力文に対する具体的な解決策を回答してください

    # 制約条件
    ・具体的で行動しやすい解決策を提示すること

    # 入力文
    #{content}

    # 出力文
    EOS
  end

  def system_setting_character
    <<~"EOS"
    あなたは、#{@character}です。
    EOS
  end

  def to_s_question_answer(content, answer)
    prefix = <<~EOS
    人格:
    #{@character}

    EOS
    prefix + super_to_s_question_answer(content, answer)
  end

  def summarize(answer)
    <<~EOS
    #{@character}の意見:
    #{answer}
    EOS
  end
end