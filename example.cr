require "./src/opencc"

# Example usage of OpenCC Crystal binding
begin
  # Create converter for Simplified to Traditional Chinese
  converter = OpenCC.new("s2t.json")

  # Test conversion
  simplified = "汉字"
  traditional = converter.convert(simplified)
  puts "Simplified: #{simplified}"
  puts "Traditional: #{traditional}"

  # Test longer text
  long_text = "中国是一个历史悠久的国家"
  converted = converter.convert(long_text)
  puts "\nLong text conversion:"
  puts "Input: #{long_text}"
  puts "Output: #{converted}"

  # Clean up
  converter.close
rescue ex
  puts "Error: #{ex.message}"
  puts "Make sure OpenCC library is installed and s2t.json config exists"
end
