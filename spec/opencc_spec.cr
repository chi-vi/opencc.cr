require "spec"
require "../src/opencc"

describe OpenCC do
  it "converts simplified to traditional chinese" do
    converter = OpenCC.new("s2t.json")
    result = converter.convert("汉字")
    result.should eq("漢字")
    converter.close
  end
  
  it "handles empty strings" do
    converter = OpenCC.new("s2t.json")
    result = converter.convert("")
    result.should eq("")
    converter.close
  end
  
  it "raises error when using closed converter" do
    converter = OpenCC.new("s2t.json")
    converter.close
    
    expect_raises(Exception, "OpenCC instance has been closed") do
      converter.convert("test")
    end
  end
  
  it "raises error for invalid config" do
    expect_raises(Exception, /Failed to initialize OpenCC/) do
      OpenCC.new("invalid_config.json")
    end
  end
end