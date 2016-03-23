class Transaction
  attr_reader :id , :product , :customer

  @@transactions = []
  @@id = 0

  def initialize(customer, product)
    @@id +=1
    @id = @@id
    @customer = customer
    @product = product
    add_to_transactions
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


  private

  def add_to_transactions
    @@transactions << self
    if (@product.stock > 0)
      @product.stock -=1
    else
      raise OutOfStockError , "#{@product.title} is out of stock"
    end
  end

end
