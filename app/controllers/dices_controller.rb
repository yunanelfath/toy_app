class DicesController < ApplicationController
  def index
    player = ['A','B','C','D']
    is_rolled = true
    round = 1
    @dice = Dice.new(min: 1, max: 6, result: nil)
    @dices = (@dice.min..@dice.max).to_a
    game_over = player.length
    while  game_over > 0
      #start round
      game_loads = []
      arr_game_over = []
      @games = player.map{|e| DicePlayer.new(name: e, roll_dice: Array.new(@dices.length), round: 0, qualification: 0)} if round == 1

      puts 'Round '+round.to_s+' After Dice Rolled'
      @games.each_with_index do |play,index|
        play.roll_dice.each_with_index do|e,index|
          play.roll_dice[index] = rand(1..6) if e.nil? || round > 1
        end
        play.round = round
        game_loads << play
        puts play.name+" = "+play.roll_dice.join("|")
      end

      filtering = game_loads.collect{|e| e.roll_dice}.map{|f| !f.include? nil}.uniq.first
      if filtering == true
        puts 'After dice moved on round '+round.to_s
        game_loads.each_with_index do |e,i|
          e.roll_dice.delete(6) if e.roll_dice.include? (6)
          arr_1 = []
          if e.roll_dice.include? 1
            e.roll_dice.map{|f| arr_1 << e.name if f == 1}
            next_index = i+1
            next_index = 0 if i == player.length-1
            e.roll_dice.delete(1)

            unless game_loads[next_index].roll_dice.present?
              while game_loads[next_index].roll_dice.blank?
                next_index +=1
                next_index = 0 if next_index > player.length-1
              end
            end
            arr_1.map{|arr| game_loads[next_index].roll_dice.push(arr)}

          end
          e.roll_dice.map!{|replace|
            if replace.is_a?(String)
              replace = 1
            else
              replace
            end
          }

        puts e.name+" = "+e.roll_dice.join("|")
        end
      end
      puts '=========================='
      game_loads.map{|ko| arr_game_over << ko.name if ko.roll_dice.blank? }
      game_over = -1 if arr_game_over.length == player.length-1
      round += 1
    end

  end
end
