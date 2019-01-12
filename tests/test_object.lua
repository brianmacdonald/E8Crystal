local suite_test = require "testing/suite_test"

local object = require "object"

return suite_test:new("object", {
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
})