
Feature: Hooks

    Background: hooks
        * def result = callonce read('classpath:helpers/Dummy.feature')
        * def username = result.username

        # after hooks
        * configure afterFeature = function(){ karate.call('classpath:helpers/Dummy.feature') }
        # * configure afterScenario = function(){ karate.call('classpath:helpers/Dummy.feature') }
        * configure afterFeature =
        """
            function() {
                karate.log('After Feature Text por favor!')
            }

        """


    Scenario: First Scenario
        * print username
        * print 'This is first scenario'

    Scenario: Second Scenario
        * print username
        * print 'This is second scenario'