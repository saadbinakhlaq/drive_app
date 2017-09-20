require 'pry'

a = [1, 4, 10]

d = a.map do |item|
  index = a.index(item)
  if !a[index + 1].nil?
    (item..a[index + 1])
  else
    (item..10/0.0)
  end
end


p d