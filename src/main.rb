# frozen_string_literal: true

require_relative './magi/magi'
require_relative './utils/openai_client'
require_relative './utils/loggable'

class Main
  include Loggable

  def execute 
    user_questions = File.readlines('./test/question.txt', encoding: Encoding::UTF_8)

    answers = []
    
    logger.debug("start!!")
    
    logger.info('少々お待ちを。')
    user_questions.each.with_index(1) do |user_question, i|
      logger.debug("質問:")
      logger.debug(user_question)
      logger.debug("")
    
      magi = Magi.new 
      answer = magi.question(user_question)
    
      logger.debug("最終的な回答:")
      logger.debug(answer)
      answers.push("#{i},#{user_question.chomp},#{answer.chomp}")
    end
    
    result = answers.join("\n")
    
    logger.info("まとめ")
    logger.info(result)

    logger.debug("end!!")
  end
end

Main.new.execute

