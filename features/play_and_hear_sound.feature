Feature: play and identify my tone

Scenario: play and identify my tone
  Given I am in locate mode
  When I am listening
  Then I should play a tone
  And I should identify it

