require_relative '../utils/loggable'
require_relative '../utils/openai_client'

class MagiUnit
  include Loggable 

  def initialize
    @client = OpenAIClient.new
    @answer_tokens = ENV['ANSWER_TOKENS']
  end

  def question(content)
    question_content = question_content(content)
    @client.completions(question_content)
  end
  
  def question_content(content)
    raise NotImplementedError
  end

  def to_s_question_answer(content, answer)
    <<~EOS
    質問:
    #{question_content(content)}
    回答:
    #{answer}

    EOS
  end
end