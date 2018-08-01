require "pry"

def consolidate_cart(cart)
  new_hash = {}
  cart.each do |hash|
    hash.each  do |item , stats|
      if new_hash[item]
        new_hash[item][:count] += 1
      else
        new_hash[item] = stats
        new_hash[item][:count] = 1
      end
    end
  end
  new_hash
end

[{:item => "Avocado", :num=>2, :cost => 5}]

def apply_coupons(cart, coupons)
  return cart  if coupons == []
  new_cart  = cart
  coupons.each do |hash|
    
    num = hash[:num]
    name = hash[:item]
    
    cart.to_a.each do |item , stats|
      if name == item && stats[:count] >= num
        new_cart[item][:count] -= num
        if new_cart["#{item} W/COUPON"]
          new_cart["#{item} W/COUPON"][:count] += 1
        else
          new_cart["#{item} W/COUPON"] = {
          :price => hash[:cost],
          :clearance => cart[item][:clearance],
          :count => 1
          }
        end
      end
    end
  end
  new_cart
end

def apply_clearance(cart)
  new_cart = cart 
 
  cart.each do |item , stats|
    if stats[:clearance]
      new_cart[item][:price] = (stats[:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
end