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
    @@transactions[index-1]
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
