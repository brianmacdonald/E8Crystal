local object = require "object"

function get_object_at(x, y)
end

function find_in_array(array, search)
    for i, item in array do
        if item == search then
            return i
        end
    end
    return -1
end


function gets_hit(self, event)
    self.hit_points = self.hit_points - event.obj.damage_mod
    if self.hit_points <= 0 then
        self.begin_animation("death")
    else
        self.begin_animation("hit")
    end
end

function gets_collided(self, event)
    if event.obj.type_name == "player" then
        if self.is_enemy or self.is_hazard then
            if self.is_lethal_hazard then
                event.obj.trigger("dies", self)
            else
                event.obj.trigger("gets_hit", self)
            end
            return
        end
        if self.is_pickup then
            self.trigger("picked_up", event.obj)
            event.obj.trigger("picks_up", self)
        end
    end
end

function dies(self, event)
    self.begin_animation("death")
end

function picked_up(self, event)
    self.begin_animation("picked_up")
end

function picks_up(self, event)
    self.begin_animation("picks_up")
end

function walks(self, event)
    --[[
        Coditions for walking.
           - direction does not have a collidable object at position
           - is not already moving (jumping, falling, etc)
    --]]
    if find_in_array(self.collisions, get_object_at(event.x, event.y).collison_type) >= 0 then
        self.begin_animation("walk")
        self.x = event.x
        self.y = event.y
    end
end

function jumps(self, event)
    --[[
        the player initiates a jump with the jump button.
        from there the jump will continue until it reaches it jump max
    --]]
    if find_in_array(self.collisions, get_object_at(event.x, event.y).collison_type) >= 0 then
        self.begin_animation("jumps")
        self.x = event.x
        self.y = event.y
        self.current_jump_power_level = self.current_jump_power_level + 1
        if self.current_jump_power_level < self.max_jump_power then
            event.x = event.x + event.delta
            event.y = event.y + event.delta
            self.trigger("jumps", event)
        end
    end
end

function falling(self, event)
    if find_in_array(self.collisions, get_object_at(event.x, event.y).collison_type) >= 0 then
        self.begin_animation("falling")
        self.x = event.x
        self.y = event.y
    end
end

function super_jumps(self, event)
    if find_in_array(self.collisions, get_object_at(event.x, event.y).collison_type) >= 0 then
        self.begin_animation("super_jumps")
        self.x = event.x
        self.y = event.y
    end
end

physical_object = {
    uuid = "1",
    x = 0,
    y = 0,
    hit_points = 99,
    damage_mod = 0,
    is_enemy = false,
    is_hazard = false,
    is_lethal_hazard = false,
    collison_type = "air",
    collisions = {},
    is_jumping = false,
    is_falling = false,
    conditions = {
        gets_hit = gets_hit,
        gets_collided = gets_collided,
        dies = dies
    }
}

function test_runner()
    local tests = {
        test_new_object = function()
            assert(object:new("foobar").type == "foobar")
        end,
        test_object_draw = function()
            local has_run = false
            local animation = function ()
                has_run = true
            end
            local obj = object:new({animations = {animation}})
            obj:draw()
            assert(has_run == true)
        end,
        test_spawn_object = function()
            local obj = object:new("foobar")
            assert(obj.is_alive == false)
            obj:spawn()
            assert(obj.is_alive == true)
            obj:kill()
            assert(obj.is_alive == false)
        end,
        test_kill_object = function()
            local obj = object:new("foobar")
            obj.is_alive = true
            obj:kill()
            assert(obj.is_alive == false)
        end,
    }
    for k, v in pairs(tests) do
        v()
        print(k .. ": " .. "Successful")
    end
end

test_runner()