class Product
  attr_reader :title , :price, :stock
  attr_writer :stock

  @@products = []

  def initialize(options={})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]
    add_to_products
  end

  def self.all
    @@products
  end

  def self.find_by_title(look_up_title)
    # fix the fact that all products is returned if no match found
    @@products.each do |product|
       return product if product.title.downcase == look_up_title.downcase
     end
     raise NoSuchTitle , "#{look_up_title} is not a product title."
  end

  def self.in_stock()
    products_in_stock = []
    @@products.each{|prod| products_in_stock << prod if prod.in_stock?}
    products_in_stock
  end

  def in_stock?()
    (@stock == 0)? false : true
  end

  private

  def add_to_products
    title_already_in_list= false
    @@products.each{|prod| title_already_in_list = true if prod.title.downcase == self.title.downcase}
    unless title_already_in_list
      @@products << self
    else
      puts "There already is a product of the name: #{self.title} in the database"
      # raise DuplicateProductError, "There already is a product of the name: #{self.title} in the database"
    end
  end

end
