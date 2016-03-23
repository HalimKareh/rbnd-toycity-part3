class Customer
  attr_reader :name

  @@customers = []

  def initialize(options={})
    @name = options[:name]

    add_to_customers
  end

  def self.all
    @@customers
  end

  def self.find_by_name(look_up_name)
    # fix the fact that all products is returned if no match found
    @@customers.each do |customer|
       return customer if customer.name.downcase == look_up_name.downcase
     end
     raise NoSuchCustomerName , "#{look_up_name} is not a customer name."
  end

  def purchase(product_purchased)
    Transaction.new(self , product_purchased)
  end


  private

  def add_to_customers
    customer_already_in_list= false
    @@customers.each{|cust| customer_already_in_list = true if cust.name.downcase == self.name.downcase}
    unless customer_already_in_list
      @@customers << self
    else
      raise DuplicateCustomerError, "There already is a customer of the name: #{self.name} in the database."
    end
   end

end
