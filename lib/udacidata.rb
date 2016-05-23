require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"
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
    CSV.open(@@data_path, "ab") do |product|
      product << [id,brand,name,price]
    end
  end

  def self.all
    CSV.table(@@data_path).map do |data|
      new(id: data[0], brand: data[1], name: data[2], price: data[3])
    end
  end

  def self.first(id = nil)
    id == nil ? all.first : all.first(id)
  end

  def self.last(id = nil)
    id == nil ? all.last : all.last(id)
  end

  def self.find(id)
    product = all.find { |product| product if product.id == id }
    raise ProductNotFoundError, " id: '#{id}' is not in the database" if product == nil
    product
  end

  def self.destroy(id)
    product = find(id)
    delete_from_db(id)
    product
  end

  def self.delete_from_db(id)
    table = CSV.table(@@data_path)
    table = table.delete_if { |row| row[0] == id}

    File.open(@@data_path, 'w') do |f|
      f.write(table.to_csv)
    end
  end

  def self.where(opts={})
    return all.select { |product| product.brand == opts[:brand] } if opts[:brand]
    return all.select { |product| product.name == opts[:name] } if opts[:name]
  end

  def update(opts={})

    updated_brand = opts[:brand] ? opts[:brand] : brand
    updated_name = opts[:name] ? opts[:name] : name
    updated_price = opts[:price] ? opts[:price] : price

    Product.destroy(id)
    Product.create(id: id, brand: updated_brand, name: updated_name, price: updated_price)
  end
end
