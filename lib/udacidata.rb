require_relative 'find_by'
require_relative 'errors'
require_relative '../data/seeds' #delete
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

  def self.find(id)
    read[id - 1]
  end

  def self.destroy(id)
    product = find(id)
    delete_from_db(id)
    product
  end

  def self.delete_from_db(id)
    table = CSV.table(DATA_PATH)
    table = table.delete_if { |row| row[0] == id}

    File.open(DATA_PATH, 'w') do |f|
      f.write(table.to_csv)
    end
  end

  def self.where(opts={})
    read.select { |product| product.brand == opts[:brand] }
  end

end

product = Udacidata.new(brand: "ColtToys", name: "Orchid Plant", price: 2.00)
product1 = Udacidata.create(brand: "Toys", name: "Orchid", price: 20.00)

db_seed
product1.save
Udacidata.find_by_brand("Toys")

product2 = Udacidata.where(brand: "Toys")
p product2
