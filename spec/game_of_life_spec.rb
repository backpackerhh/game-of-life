require 'matrix'
require 'game_of_life'

RSpec.describe GameOfLife do
  describe '#current_generation' do
    it 'converts a given array of arrays to a matrix' do
      array_of_arrays = [
        [true, false],
        [false, false]
      ]
      game = described_class.new(array_of_arrays)

      expect(game.current_generation).to be_a(Matrix)
      expect(game.current_generation[0, 0]).to eq(true)
    end

    it 'keeps a given matrix as a matrix' do
      current_generation = Matrix[
        [true, false],
        [false, false]
      ]
      game = described_class.new(current_generation)

      expect(game.current_generation).to be_a(Matrix)
      expect(game.current_generation[0, 0]).to eq(true)
    end
  end

  describe '#next_generation' do
    it 'returns matrix for next generation with underpopulation' do
      current_generation = Matrix[
        [false, false, false],
        [false, true, false],
        [false, false, false]
      ]
      game = described_class.new(current_generation)

      expect(game.next_generation).to eq(Matrix[
        [false, false, false],
        [false, false, false],
        [false, false, false]
      ])
    end

    it 'returns matrix for next generation with stasis and reproduction' do
      current_generation = Matrix[
        [false, false, false],
        [false, true, true],
        [false, true, false]
      ]
      game = described_class.new(current_generation)

      expect(game.next_generation).to eq(Matrix[
        [false, false, false],
        [false, true, true],
        [false, true, true]
      ])
    end

    it 'returns matrix for next generation with overpopulation and reproduction' do
      current_generation = Matrix[
        [false, true, true],
        [true, true, true],
        [false, false, false]
      ]
      game = described_class.new(current_generation)

      expect(game.next_generation).to eq(Matrix[
        [true, false, true],
        [true, false, true],
        [false, false, false]
      ])
    end
  end

  describe '#next_generation!' do
    it 'overrides current generation using next generation' do
      current_generation = Matrix[
        [false, false, false],
        [false, true, true],
        [false, true, false]
      ]
      game = described_class.new(current_generation)
      next_generation = game.next_generation

      expect(game.current_generation).not_to eq(next_generation)

      game.next_generation!

      expect(game.current_generation).to eq(next_generation)
    end

    it 'allows to generate new generations of cells with subsequent calls' do
      current_generation = Matrix[
        [true, false, false],
        [false, true, true],
        [false, true, false]
      ]
      game = described_class.new(current_generation)

      game.next_generation!

      expect(game.current_generation).to eq(Matrix[
        [false, true, false],
        [true, true, true],
        [false, true, true]
      ])

      game.next_generation!

      expect(game.current_generation).to eq(Matrix[
        [true, true, true],
        [true, false, false],
        [true, false, true]
      ])
    end
  end
end
