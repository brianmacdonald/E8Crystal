-- test_runner module

local test_runner = {}

-- Create new test runner with an array of test suites.
-- @param test_suites (array<test_suite>): test_suites for runner
-- @return new test_runner instance
function test_runner:new(test_suites)
    self.test_suites = test_suites
    return self
end

-- Run all test suites for runner.
function test_runner:run()
    for _, ts in ipairs(self.test_suites) do
       ts:run()
    end
end

return test_runner