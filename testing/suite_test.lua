-- module suite_test
local utils = require "utils"

local unit_test = require "testing/unit_test"

local suite_test = {}

-- Create new suite test
-- @param suite_name (string): name of suite
-- @param tests (array<key, function>): table of unit test name and functions to be executed as unit tests
-- @return instance of a suite test
function suite_test:new(suite_name, tests)
    self.suite_name = suite_name
    self.tests = tests
    return self
end

-- Run all tests as unit tests
function suite_test:run()
    for _, k in pairs(utils.sortedKeys(self.tests)) do
        local v = self.tests[k]
        local test_suite = {}
        test_suite[k] = unit_test:new(k)
        v(test_suite[k])
        test_suite[k]:complete()
    end
end

return suite_test