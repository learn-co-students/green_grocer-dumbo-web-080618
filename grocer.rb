require 'pry'
def consolidate_cart(cart)
  # code here
  new_cart = {}
  cart.each_with_index do |e, i|
    e.each do |k, v|
      v[:count] = cart.count(e)
    end
    new_cart.merge!(cart[i])
  end

  new_cart
end

def apply_coupons(cart, coupons)
  # code here
  new_cart = {}
  if coupons.length < 1
    return cart
  end
  cart.each do |key, data|
    for i in 0..coupons.length-1
      if coupons[i][:item] == key && data[:count] >= coupons[i][:num]
        
        new_cart["#{key} W/COUPON"] = {:price => coupons[i][:cost], :clearance => cart[key][:clearance], :count => data[:count]/coupons[i][:num]}
        data[:count] %= coupons[i][:num]
      end 
      new_cart.merge!(cart)
    end
  end
  #binding.pry
  new_cart
end

def apply_clearance(cart)
  # code here
  new_cart = {}
  cart.each do |key, data|
    if data[:clearance] == true
      data[:price] = (data[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  total_cost = 0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cart.each do |key, data|
    total_cost += (data[:price] * data[:count])
  end
  if total_cost > 100.0
    total_cost *= 0.9
  end
  total_cost
end