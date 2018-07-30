require 'pry'
def consolidate_cart(cart)
  new_hash = {}
  cart.each do |object|
    object.each do |item, info|
      if new_hash.keys.include?(item)
        new_hash[item][:count] += 1
      else
        new_hash[item] = {}
        info.each do |attribute, val|
          new_hash[item][attribute] = val
        end
        new_hash[item][:count] = 1
      end
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  new_cart = cart.clone
  cart.each do |item, info|
    inspect =  coupons.find {|object| object[:item] == item }
    if inspect != nil
      remainder = info[:count]%inspect[:num]
      coupon_count = info[:count]/inspect[:num]
      new_cart[item][:count] = remainder
      new_cart["#{item} W/COUPON"] = {
        price: inspect[:cost],
        clearance: info[:clearance],
        count: coupon_count
      }
    end
  end
  new_cart
end

def apply_clearance(cart)
  cart.each do |item_name, info_hash|
    if info_hash[:clearance]
      cart[item_name][:price] = (0.8*cart[item_name][:price]).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  total = 0
  clearance_cart.each do |item_name, info_hash|
    total += info_hash[:price]*info_hash[:count]
  end
  if total > 100
    return (total*0.9).round(2)
  else
    return total
  end
end
