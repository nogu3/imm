require_relative './magi_unit'

class AnswerUnit < MagiUnit
  attr_reader :character
  alias :super_to_s_question_answer :to_s_question_answer

  def initialize(character)
    @character = character
    super()
  end

  def question_content(content)
    question_content = <<~"EOS"
    あなたは#{@character}という人格の持ち主
    20文字以内で人格に沿って質問に回答すること
    #{content}
    EOS
    question_content
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