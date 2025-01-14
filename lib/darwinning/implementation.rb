module Darwinning
  module Implementation

    def genes
      gene_ranges.map { |k,v| Gene.new(name: k, value_range: v) }
    end

    def build_population(fitness_goal, population_size = 10, generations_limit = 100, 
                         evolution_types = Population::DEFAULT_EVOLUTION_TYPES)
      Population.new(organism: self, population_size: population_size,
                     generations_limit: generations_limit, fitness_goal: fitness_goal,
                     evolution_types: evolution_types)
    end

    def is_evolveable?
      has_gene_ranges? &&
      gene_ranges.is_a?(Hash) &&
      gene_ranges.any? &&
      valid_genes? &&
      has_fitness_method?
    end

    private

    def has_gene_ranges?
      self.constants.include?(:GENE_RANGES)
    end

    def has_fitness_method?
      self.instance_methods.include?(:fitness)
    end

    def gene_ranges
      self::GENE_RANGES
    end

    def valid_genes?
      genes.each do |gene|
        return false unless self.method_defined? gene.name
      end
      true
    end

  end
end