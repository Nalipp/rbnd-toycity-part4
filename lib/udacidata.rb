require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  DATA_PATH = File.dirname(__FILE__) + "/../data/data.csv"
  attr_reader :id, :brand, :name, :price

  def initialize(opts={})
    @id  = opts[:id]
    @brand = opts[:brand]
    @name = opts[:name]
    @price = opts[:price]
  end

  def self.create(attributes = nil)
    product = new(attributes)
    product.save
    product
  end

  def save
    CSV.open(DATA_PATH, "ab") do |product|
      product << [id,brand,name,price]
    end
  end

  def self.all
    CSV.table(DATA_PATH).map { |product| product }
  end

end
