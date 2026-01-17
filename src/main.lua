---@diagnostic disable: lowercase-global

player = Player.new()
state = Start

function _init()
    -- activate dev mode
    poke(0x5f2d, 1)
    -- change transparency color
    palt(15, true)
    palt(0, false)
end

function _update()
    state.update()
end

function _draw()
    cls()
    state.draw()
end
