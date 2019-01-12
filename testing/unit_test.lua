-- unit_test module

local unit_test = {}

-- Creates new unit test
-- @param message (string): name, or some type of message for the test suite.
-- @return new unit test instance
function unit_test:new(message)
    self.message = message
    self.assert_passed = 0
    self.has_failed_test = false
    return self
end

-- Asserts if true. Mean to be used as a safe assert instead of `assert` that ends execution.
-- @param bool (boolean): condition to check
-- @return unit test instance, which could be useful for chaining
function unit_test:assert(bool)
    if bool then
        self.assert_passed = self.assert_passed + 1
    end
    if not self.has_failed_test then
        if bool == false then
           self.has_failed_test = true
        end
    end
    return self
end

-- Mark the end of the unit tests
function unit_test:complete()
    if self.message == nil then
        print("====== Test  ======")
    else
        print("====== Test " .. self.message .. " ======")
    end
    if self.has_failed_test then
        assert(false)
    end
    print("Asserts passed: " .. self.assert_passed)
end

return unit_test