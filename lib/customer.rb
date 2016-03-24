class Customer
  attr_reader :name , :customer_transactions

  @@customers = []

  def initialize(options={})
    @name = options[:name]
    @customer_transactions = []
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
    @customer_transactions << Transaction.new(self , product_purchased)
  end

  def print_transaction_at(index)
    @customer_transactions[index].transaction_to_s
  end

  def print_all_transactions
    s=""
    @customer_transactions.length.times{|nb| s<< print_transaction_at(nb)<< "\n"}
    s
  end

  def total_amount_spent
    tot = 0
    @customer_transactions.each{|tran| tot += tran.product.price}
    @name << " has spent $"<<tot.to_s<<" at Toy City!"
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
