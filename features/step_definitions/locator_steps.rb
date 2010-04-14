Given /^I am in locate mode$/ do
  @locator = Locator.new 
end

When /^I am listening$/ do
  @locator.run
end

Then /^I should play a tone$/ do
  @locator.tone_played?.should be_true
end

Then /^I should identify it$/ do
  tones = @locator.heard_tones
  tones.count.should eql 1
end

