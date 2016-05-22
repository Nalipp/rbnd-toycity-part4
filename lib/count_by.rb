class Module
  def create_counter_methods(*attributes)
    attributes.each do |attribute|
      count_by_methods = %Q{
        def self.count_by_#{attribute}(products)
          uniq_products = products.map { |product| product.#{attribute} }.uniq
          uniq_products.each_with_object(Hash.new(0)) do |product,count|
            product.to_s + (count[product] += 1).to_s
          end
        end
      }
      class_eval(count_by_methods)
    end
  end

  def create_printer_format_methods(*attributes)
    attributes.each do |attribute|
      print_format_methods = %Q{
        def self.print_#{attribute}_format(products)
          count_by_#{attribute}(products).each do |product|
            puts "  - " + product[0].to_s + ": " + product[1].to_s
          end
        end
      }
      class_eval(print_format_methods)
    end
  end
end
