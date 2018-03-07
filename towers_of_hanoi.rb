class TowersOfHanoi
  attr_reader :towers
  def initialize
    @log_move = 0
    @towers = [[3, 2, 1], [], []]
    @disk = { nil => "   ", 1 => "o  ", 2 => "oo ", 3 => "ooo" }
  end
  def render
    intro
    2.downto(0) do |i|
      layer = towers.map{ |tower| @disk[tower[i]] }
      puts " " + layer.join(" ")
    end
    puts " --- --- ---"
    puts "  0   1   2 "
    puts
  end
  def play
    render
    until won?
      from_tower = get_move("move disk from #")
      to_tower = get_move("move disk to   #")
      move(from_tower, to_tower) if valid_move?(from_tower, to_tower)
      render
    end
    game_over
  end
  private
  def intro
    system("clear") || system("cls")
    puts "let's play tower of hanoi!"
    puts
  end
  def won?
    towers[1..2].any?{ |tower| tower == [3, 2, 1] }
  end
  def get_move(prompt)
    print prompt
    gets.chomp.to_i
  end
  def game_over
    puts "congrats, you win!"
    puts "you made #{@log_move} moves."
  end
  def valid_move?(from_tower, to_tower)
    from_tower, to_tower = towers.values_at(from_tower, to_tower)
    return false unless from_tower && to_tower
    !from_tower.empty? && (to_tower.empty? || from_tower.last < to_tower.last)
  end
  def move(from_tower, to_tower)
    towers[to_tower] << towers[from_tower].pop
    @log_move += 1
  end
end

if __FILE__ == $PROGRAM_NAME
  TowersOfHanoi.new.play
end