local object = {}

function object:new(type)
    self.type = type
    self.is_alive = false
    self.animations = type.animations
    return self
end

function object:draw()
    for condition, animation in ipairs(self.animations) do
        if condition then
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

function object:trigger(event_type, event)
     if self.event_handlers[event_type] ~= nil then
        for i, event_handler in ipairs(self.event_handlers[event_type]) do
            event_handler(event)
        end
     end
end

return object
