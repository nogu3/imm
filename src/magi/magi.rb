require_relative './answer_unit'
require_relative './aggregate_unit'
require_relative './choise_character_unit'

class Magi
  def initialize
    @choise_charcter_unit = ChoiseCharcterUnit.new
    @aggregate_unit = AggregateUnit.new
  end

  def question(content)
    characters = choise_charcters(content)
    @answer_units = characters.map { |character| AnswerUnit.new(character) }

    queue = Queue.new
    threads = @answer_units.map do|answer_unit|
      Thread.new do
        answer = answer_unit.question(content)
        puts answer_unit.to_s_question_answer(content, answer)

        summarize = answer_unit.summarize(answer)
        queue.push(summarize)
      end
    end

    threads.each(&:join)
    opinion = ""
    while !queue.empty?
      opinion += "#{queue.pop}\n"
      opinion += "\n"
    end
    answer = @aggregate_unit.question(opinion)
    puts @aggregate_unit.to_s_question_answer(opinion, answer)
    answer
  end

  def choise_charcters(user_question)
    @choise_charcter_unit.choise(user_question)
  end

  def all_characters(&)
    @answer_units.each(&)
  end
end