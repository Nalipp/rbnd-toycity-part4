require_relative 'count_by'

module Analyzable
  create_counter_methods :brand, :name
  create_printer_format_methods :brand, :name

  def average_price(products)
    price_total = products.map { |product| product.price.to_f }.reduce(:+) / products.length
    price_total.to_f.round(2)
  end

  def print_report(products)
    puts "Average Price: $" + average_price(products).to_s
    puts "Inventory by Brand:"
    print_brand_format(products).to_s
    puts "Inventory by Name:"
    print_name_format(products).to_s
  end
end
