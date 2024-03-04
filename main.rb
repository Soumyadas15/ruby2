class Product
  attr_accessor :name, :price, :quantity, :type

  def initialize(name, price, quantity, type)
    @name = name
    @price = price
    @quantity = quantity
    @type = type
  end

  def to_s
    "#{@name}, #{@price} RS, #{@quantity}, #{@type}"
  end
end

class InventorySystem
  def initialize
    @products = []
  end

  def add(product)
    @products << product
  end

  def removeProductByName(name)
    @products.reject! { |product| product.name == name }
  end

  def countProducts
    @products.length
  end

  def printProducts
    @products.each { |product| puts product }
  end

  def printProductsByType(type)
    @products.select { |product| product.type == type }.each { |product| puts product }
  end

  def getQuantityByName(name)
    product = @products.find { |p| p.name == name }
    product ? product.quantity : nil
  end

  def updateQuantityByName(name, quantity)
    product = @products.find { |p| p.name == name }
    product.quantity += quantity if product
  end

  def totalCost(purchases)
    total_cost = 0
    purchases.each do |purchase_name, purchase_quantity|
      product = @products.find { |p| p.name == purchase_name }
      total_cost += product.price * purchase_quantity if product
    end
    total_cost.round
  end
end

inventory = InventorySystem.new

initial_products = [
  Product.new("lettuce", 10.5, 50, "Leafy green"),
  Product.new("cabbage", 20, 100, "Cruciferous"),
  Product.new("pumpkin", 30, 30, "Marrow"),
  Product.new("cauliflower", 10, 25, "Cruciferous"),
  Product.new("zucchini", 20.5, 50, "Marrow"),
  Product.new("yam", 30, 50, "Root"),
  Product.new("spinach", 10, 100, "Leafy green"),
  Product.new("broccoli", 20.2, 75, "Cruciferous"),
  Product.new("garlic", 30, 20, "Leafy green"),
  Product.new("silverbeet", 10, 50, "Marrow")
  
]

initial_products.each { |product| inventory.add(product) }

puts "Initial total products in inventory: #{inventory.countProducts}"

inventory.add(Product.new("Potato", 10, 50, "Root"))
puts "\nAfter adding Potato:"

inventory.printProducts
puts "Total products now: #{inventory.countProducts}"

puts "\nProducts of type 'Leafy green':"
inventory.printProductsByType("Leafy green")

inventory.removeProductByName("garlic")
puts "\nAfter removing garlic:"
puts "Total products now: #{inventory.countProducts}"

inventory.updateQuantityByName("cabbage", 50)
puts "\nUpdated quantity of cabbage: #{inventory.getQuantityByName("cabbage")}"

purchase = { "lettuce" => 1, "zucchini" => 2, "broccoli" => 1 }
puts "Total cost for the purchase: #{inventory.totalCost(purchase)} RS"