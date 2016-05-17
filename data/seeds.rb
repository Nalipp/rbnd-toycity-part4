require 'faker'
require 'csv'

def db_seed
  @data_path = File.dirname(__FILE__) + "/../data/data.csv"
  CSV.open(@data_path, "wb") do |csv|
    10.times do |id|
      csv << [id + 1, Faker::Hipster.word, Faker::Commerce.product_name, Faker::Commerce.price]
    end
  end
end
