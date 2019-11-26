require 'matrix'

class GameOfLife
  attr_reader :current_generation

  LIVE_STATUS = true
  DEAD_STATUS = false

  def initialize(current_generation)
    @current_generation = Matrix[*current_generation]
  end

  def next_generation
    @next_generation = current_generation.dup

    current_generation.each_with_index do |cell, y, x|
      live_neighbors = neighbors_for(x, y).count(LIVE_STATUS)

      if underpopulation_of?(live_neighbors) || overpopulation_of_live_cells?(cell, live_neighbors)
        @next_generation[x, y] = DEAD_STATUS
      elsif reproduction_of_died_cell?(!cell, live_neighbors)
        @next_generation[x, y] = LIVE_STATUS
      end
    end

    @next_generation
  end

  def next_generation!
    @current_generation = next_generation
  end

  private

  def neighbors_for(column, row)
    coordinates_for(column, row).map do |coordinates|
      current_generation[*coordinates] if within_boundaries?(*coordinates)
    end.compact
  end

  def coordinates_for(column, row)
    [
      [column - 1, row - 1],
      [column - 1, row],
      [column - 1, row + 1],
      [column, row - 1],
      [column, row + 1],
      [column + 1, row - 1],
      [column + 1, row],
      [column + 1, row + 1]
    ]
  end

  def within_boundaries?(column, row)
    column.between?(0, current_generation.column_count - 1) &&
      row.between?(0, current_generation.row_count - 1)
  end

  def underpopulation_of?(live_neighbors)
    live_neighbors < 2
  end

  def overpopulation_of_live_cells?(live_cell, live_neighbors)
    live_cell && live_neighbors > 3
  end

  def reproduction_of_died_cell?(died_cell, live_neighbors)
    died_cell && live_neighbors == 3
  end
end
