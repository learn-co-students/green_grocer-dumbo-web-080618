def consolidate_cart(cart)
  # code here
  new_cart = {}
  cart.each { |hash|
    hash.each { |name, describe|
      if new_cart[name]
        new_cart[name][:count] += 1
      else
        new_cart[name] = describe
        new_cart[name][:count] = 1
      end
    }
  }
  new_cart
end

def apply_coupons(cart, coupons)
  # code here
  return cart if coupons == []

  new_cart = cart

  coupons.each { |coupon|
    name = coupon[:item]
    num_of_c = coupon[:num]

    if cart.include?(name) && cart[name][:count] >= num_of_c
      new_cart[name][:count] -= num_of_c
      if new_cart["#{name} W/COUPON"]
        new_cart["#{name} W/COUPON"][:count] += 1
      else
        new_cart["#{name} W/COUPON"] = {
          :price => coupon[:cost],
          :clearance => new_cart[name][:clearance],
          :count => 1
        }
      end
    end
  }
  new_cart
end

def apply_clearance(cart)
  # code here
  new_cart = cart
  cart.each { |name, hash|
      if hash[:clearance]
        new_cart[name][:price] = (cart[name][:price] * 0.8).round(2)
      end
  }
  new_cart
end

def checkout(cart, coupons)
  # code here
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)

  total = 0
  new_cart.each { |name, hash|
    total += (hash[:price] * hash[:count])
  }

  if total >= 100
    total *= 0.9
  end

  total
end
