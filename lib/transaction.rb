class Transaction
  attr_reader :id , :product , :customer

  @@transactions = []
  @@id = 0

  def initialize(customer, product)
    if product.stock > 0
      @@id +=1
      @id = @@id
      @customer = customer
      @product = product
      add_to_transactions
    else
      raise OutOfStockError , "#{@product.title} is out of stock"
    end
  end

  def self.all
    @@transactions
  end

  def self.find(index)
    if @@transactions.length >= index-1
      @@transactions[index-1]
    else
      raise NoTransactionOfThisID, "The id #{index} is not a valid transaction id."
    end
  end

  def transaction_to_s
    s=""
    s<<@customer.name << " bought a " << @product.title << " at the price of $" << @product.price.to_s << "."
    s
  end

  private

  def add_to_transactions
    @@transactions << self
    @product.stock -=1
  end

end
