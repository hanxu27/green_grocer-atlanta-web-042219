require "pry"

def consolidate_cart(cart)
  # code here
  output = {}
  
  cart.each do |item|
    if !output.has_key?(item.keys[0])
      output[item.keys[0]] = item.values[0]
      output[item.keys[0]][:count] = 1
    else
      output[item.keys[0]][:count] += 1
    end
  end
  output
end

def apply_coupons(cart, coupons)
  # code here
  output = {}
  cart.each do |item, data|
    coupons.each do |coupon_item|
      #binding.pry
      if item == coupon_item[:item] && data[:count] >= coupon_item[:num]
        if !output["#{item} W/COUPON"]
          output["#{item} W/COUPON"] = {price: coupon_item[:cost], clearance: data[:clearance], count: 1}
          data[:count] -= coupon_item[:num]
        else
          output["#{item} W/COUPON"][:count] += 1
          data[:count] -= coupon_item[:num]
        end
      end
    end
  end
  cart.each do |item, data|
      output[item] = data
  end
  cart = output
end

def apply_clearance(cart)
  # code here
  cart.each do |item, data|
    if data[:clearance]
      #binding.pry
      data[:price] = (data[:price]*0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  total = 0
  
new_cart = apply_clearance(apply_coupons(consolidate_cart(cart),coupons))
  
  new_cart.each do |item, data|
    #binding.pry
    total += data[:price]*data[:count]
   end
  total > 100 ? total*0.9.round(2) : total.round(2)
end
