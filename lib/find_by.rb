class Module
  def create_finder_methods(*attributes)
    attributes.each { |attribute|
      find_by_methods = %Q{
        def self.find_by_#{attribute}(#{attribute})
          all.select { |product| product.#{attribute} == #{attribute}}[0]
        end
      }
      class_eval(find_by_methods)}
  end
end
