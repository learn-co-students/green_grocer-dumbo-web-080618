require 'pry'
test_cart = [
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"KALE"    => {:price => 3.0, :clearance => false}}
]

def consolidate_cart(cart)
  cart.each_with_object({}) do |item, result|
    item.each do |object, info|
      # puts "Key: #{k} Value: #{v}"
      if (result[object])
        info[:count] += 1 
      else
        info[:count] = 1
        result[object] = info
      end
    end
  end
end


def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    name = coupon[:item]
    if (cart[name] && cart[name][:count] >= coupon[:num])
      if (cart["#{name} W/COUPON"])
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |key, value|
    if (value[:clearance] == true)
      price = value[:price] * 0.8
      value[:price] = price.round(2)
    end
  end
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  coupons_cart = apply_coupons(consolidated_cart, coupons)
  total_cart = apply_clearance(coupons_cart)
  total = 0 
  total_cart.each do |item, details|
    total += details[:price] * details[:count]
  end
  if (total > 100)
    total = total * 0.9
  end
  total
end