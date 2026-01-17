---@class
State = {}
State.__index = State

function State.new(update, draw)
  local created = {}
  setmetatable(created, State)
  created.update = update
  created.draw = draw
  return created
end

Start = State.new(
  function ()
    for i=0,3 do
      if btn(i) then
        state = Running
      end
    end
  end,
  function ()
    print("Press any key!")
  end
)

Running = State.new(
  function ()
    player:update()
  end,
  function ()
    map()
    camera(player.pos.x - 16., 0.)
    player:draw()
  end
)

Lost = State.new(
  function ()
    for i=0,3 do
      if btn(i) then
        state = Running
        player = Player.new()
      end
    end
  end,
  function ()
    camera(0., 0.)
    print("You lost the game!")
  end
)
