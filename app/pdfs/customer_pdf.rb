class CustomerPdf < Prawn::Document
  def initialize(customers)
    super()
    @customers= Customer.all
    customer_id
  end

  def customer_id
    table customer_id_all do
      row(0).font_style= :bold
      columns(1..3).align=:right
      self.row_colors=["DDDDDD","FFFFFF"]
      self.header=true
    end
  end
  def customer_id_all
    [["Customer Names", "Address", "Phone Number"]] + 
    @customers.map do |customer|
      [customer.name, customer.address, customer.phone]
    end
  end
  
end