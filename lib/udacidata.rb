require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  DATA_PATH = File.dirname(__FILE__) + "/../data/data.csv"
  attr_reader :id, :brand, :name, :price
  create_finder_methods :brand, :name

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

  def self.read
    CSV.table(DATA_PATH).map do |data|
      new(id: data[0], brand: data[1], name: data[2], price: data[3])
    end
  end

  def self.all
    read
  end

  def self.first(attributes = 0)
    attributes > 0 ? read.first(attributes) : read.first
  end

  def self.last(attributes = 0)
    attributes > 0 ? read.last(attributes) : read.last
  end

  def self.find(num)
    read.each { |item| return item if item.id == num}
  end

end

product = Udacidata.new(brand: "ColtToys", name: "Orchid Plant", price: 2.00)
product1 = Udacidata.create(brand: "Toys", name: "Orchid", price: 20.00)

puts Udacidata.find(3).id
