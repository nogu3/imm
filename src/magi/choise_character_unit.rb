require_relative './magi_unit'

class ChoiseCharcterUnit < MagiUnit
  def question_content(content)
    <<~"EOS"
    # 命令文
    入力文に最適な3人の人格を決めてください。

    # 制約条件
    ・人格は半角のカンマ区切りで返すこと
    ・人格の名称以外は返さないこと
    ・人格の説明は不要

    # 入力文
    #{content}

    # 出力文
    EOS
  end

  def system_setting_character
    <<~"EOS"
    あなたはプロンプトエンジニアリングのプロです。
    EOS
  end

  def choise(user_question)
    characters_str = question(user_question)
    characters_str.split(/,|、/).map {|character| character.strip}
  end
end