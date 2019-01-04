local object = {}

function object:new(type)
    self.type = type
    self.is_alive = false
    self.animations = type.animations
    return self
end

function object:draw()
    for condition, animation in ipairs(self.animations) do
        if conditio then
            animation()
        end
    end
end

function object:spawn()
    self.is_alive = true
end

function object:kill()
    self.is_alive = false
end

return object
