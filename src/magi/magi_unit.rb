require_relative '../utils/loggable'
require_relative '../utils/openai_client'

class MagiUnit
  include Loggable

  def initialize(character)
    @character = character
    @client = OpenAIClient.new
  end

  def question(content)
    question_content = <<~"EOS"
      あなたは#{@character}という人格の持ち主です
      以下の質問に人格に沿って回答してください
      質問:
      #{content}
    EOS
    puts question_content
    @client.completions(question_content)
  end
end