
def comma_numbers(number, delimiter = ',')
  res = number.to_i.to_s.reverse.gsub(%r{([0-9]{3}(?=([0-9])))}, "\\1#{delimiter}").reverse
  res += '.' + (number - number.to_i).to_s.split('.')[1] if (number - number.to_i > 0)
  return res
end
