local tests = {}

local object = require "object"
local utils = require "utils"

local unit_test = {}

function unit_test:new(message)
    self.message = message
    self.assert_passed = 0
    self.has_failed_test = false
    return self
end

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

function test_runner()
    local tests = {
        test_new_object = function(t)
            t:assert(object:new("foobar").type == "foobar")
        end,
        test_object_draw = function(t)
            local has_run = false
            local animation = function ()
                has_run = true
            end
            local obj = object:new({animations = {animation}})
            obj:draw()
            t:assert(has_run == true)
        end,
        test_spawn_object = function(t)
            local obj = object:new("foobar")
            t:assert(obj.is_alive == false)
            obj:spawn()
            t:assert(obj.is_alive == true)
            obj:kill()
            t:assert(obj.is_alive == false)
        end,
        test_kill_object = function(t)
            local obj = object:new("foobar")
            obj.is_alive = true
            obj:kill()
            t:assert(obj.is_alive == false)
        end,
    }
    for _, k in pairs(utils.sortedKeys(tests)) do
        local v = tests[k]
        local test_suite = {}
        test_suite[k] = unit_test:new(k)
        v(test_suite[k])
        test_suite[k]:complete()
    end
end

tests.test_runner = test_runner

return tests