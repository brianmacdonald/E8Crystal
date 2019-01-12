local test_runner = require "testing/test_runner"
local test_object = require "tests/test_object"

local runner = test_runner:new({test_object})
runner:run()