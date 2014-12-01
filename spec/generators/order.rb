class OrderDispatch
  using Nifty::Variants

  def self.send_to(place)
    place
  end

  def self.dispatch(order)
    cases order,
      pickup: ->(o) { send_to(o.store_id) },
      digital: ->(o) { send_to(o.email) },
      delivery: ->(o) { send_to(o.address) },
      else: ->(o) { raise "Don't know how to handle #{o.type}" }
  end
end

class Order
  attr_reader :type, :address, :email, :store_id

  def initialize(type: :pickup, address: "", email: "", store_id: "")
    @type = type
    @address = address
    @email = email
    @store_id = store_id
  end

  def to_variant
    [type, self]
  end
end

Generative.register_generator :order do |_|
  Order.new(
            type: [:pickup, :digital, :delivery].sample,
            address: Generative.generate(:string, limit: 100),
            email: Generative.generate(:string, limit: 100),
            store_id: Generative.generate(:integer)
           )
end
