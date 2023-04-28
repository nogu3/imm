# frozen_string_literal: true

require_relative './magi/magi'
require_relative './utils/openai_client'
require_relative './utils/loggable'

class Main
  include Loggable

  def execute 
    user_questions = File.readlines('./test/question.txt', encoding: Encoding::UTF_8)

    queue = Queue.new
    
    logger.debug("start!!")
    
    logger.info('少々お待ちを。')
    threads = user_questions.map.with_index(1) do |user_question, i|
      Thread.new do
        logger.debug("質問:")
        logger.debug(user_question)
        logger.debug("")
        
        magi = Magi.new 
        answer = magi.question(user_question)
        
        logger.debug("最終的な回答:")
        logger.debug(answer)
        queue.push({
          index: i,
          answer: "#{i},#{user_question.chomp},#{answer.chomp}\n"
        })
      end
    end

    threads.each(&:join)
    answers = []
    while !queue.empty?
      answers.push(queue.pop)
    end

    result = answers.sort{|prev_answer, next_answer| prev_answer[:index] <=> next_answer[:index]}
                    .map {|answer|answer[:answer]}
                    .join()
    
    logger.info("まとめ")
    logger.info(result)

    logger.debug("end!!")
  end
end

Main.new.execute

