function get_sprite(vec2)
    return mget(flr(vec2.x / 8), flr(vec2.y / 8))
end
  
function has_flag(vec2, flag)
    return fget(get_sprite(vec2), flag)
end

function clamp(min, val, max)
    if val < min then
        return min
    end
    if val > max then
        return max
    end
    return val
end

---Generic 2D vector.
---@class Vec2
---@field x number the x component of this vector
---@field y number the y component of this vector
Vec2 = {}
Vec2.__index = Vec2

---Creates a new 2D vector. If no x or y is supplied, it will use 0 instead.
---@param data table the x and y coordinate for the vector
---@return Vec2 vector the newly created vector
---@nodiscard
function Vec2.new(data)
    assert(data ~= nil)
    local created = {}
    setmetatable(created, Vec2)
    created.x = data.x or 0
    created.y = data.y or 0
    return created
end

Zero = Vec2.new{ x=0, y=0 }

function Vec2:copy()
    return Vec2.new(self)
end

function Vec2:add(other)
    self.x = self.x + (other.x or 0)
    self.y = self.y + (other.y or 0)
end

function Vec2:sub(other)
    self.x = self.x - (other.x or 0)
    self.y = self.y - (other.y or 0)
end

function Vec2:magnitude()
    return sqrt(self.x * self.x + self.y * self.y)
end

function Vec2:norm()
    local mag = self:magnitude()
    if mag ~= 0 then
        self.x = self.x / mag
        self.y = self.y / mag
    end
end

function Vec2:__tostring()
    return "Vec2[x=" .. self.x .. ", y=" .. self.y .. "]"
end

---@class List<E>: { [integer]: E }
List = { __len=0 }
List.__index = List

---Creates a new list with an init capacity of 0.
---@return List
---@nodiscard
function List.new()
    local created = {}
    setmetatable(created, List)
    created.__len = 0
    return created
end

---@return List
---@nodiscard
function List.from(data)
    local created = List.new()
    created:add_all(data)
    return created
end

---Adds the given element to the end of the list.
---@param e any the element to add
function List:add(e)
    self[self.__len] = e
    self.__len = self.__len + 1
end

---Adds all given elements to the end of the list.
---@param table any the table of elements to add
function List:add_all(table)
    assert(table ~= nil)
    for _, value in ipairs(table) do
        self:add(value)
    end
end

---Sets the element of a given index in the list to the new given element.
---@param i integer the index of the element that is set
---@param e any the new element to set
function List:set(i, e)
    assert(i < self.__len and i >= 0, "Index out of bounds")
    self[i] = e
end

---Returns the currently presend element at the given index of the list.
---@param i integer the index of the element you want to get
---@return any e the element at the given position
---@nodiscard
function List:get(i)
    assert(i < self.__len and i >= 0, "Index out of bounds")
    return self[i]
end

---Removes and returns the element at the given index of the list. This will shift all element
---indices that are presend after this element one to the left.
---@param i integer the index of the element that should be removed
---@return any e the element that was removed
function List:pop(i)
    assert(i < self.__len and i >= 0, "Index out of bounds")
    -- cache removed value
    local val = self[i]
    -- rotate index of all following values
    for j = i, self.__len - 2 do
        self[j] = self[j+1]
    end
    -- decrease len of List
    self.__len = self.__len - 1
    -- delete last unused index
    self[self.__len] = nil
    -- deli(self.__len) TODO: replace with pico 8 function
    return val
end

function List:clear()
    for i = 0, self:len()-1 do
        self[i] = nil
    end
    self.__len = 0
end

function List:is_empty()
    return self:len() == 0
end

function List:iter()
    local i = -1
    local l = self:len()
    return function ()
        i = i+1
        if i<l then return self[i] end
    end
end

---@return integer len the len or number of elements of this list
---@nodiscard
function List:len()
    return self.__len
end

function List:__tostring()
    if self.__len > 0 then
        local content = "List[" .. self[0]
        for i = 1, self.__len-1 do
            content = content .. ", " .. self[i]
        end
        return content .. "]"
    else
        return "List[]"
    end
end
