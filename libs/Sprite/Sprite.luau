--!strict

-- // Variables
local Sprite = {}

local MAX_IMAGE_SIZE = 1024 -- pixels

-- // Configuration
Sprite.__index = Sprite

-- // Types
type self = {
	_object: ImageLabel,
	_width: number,
	_height: number,
	_columns: number,
	_rows: number,
	_frameAmount: number,
	_fps: number,
	_states: {
		Playing: boolean,
		Cleaned: boolean,
	},
	_index: number,
	_timeInterval: number,
	_offsets: {},
}

export type SpriteInfo = {
	ImageObject: ImageLabel,
	Width: number?,
	Height: number?,
	Rows: number,
	Columns: number,
	NumberOfFrames: number?,
	ImageId: string?,
	FPS: number?,
}
export type Sprite = typeof(setmetatable({} :: self, Sprite))

-- // Functions
function _Init(self: Sprite)
	local RealWidth, RealHeight
	local CurrentRow, CurrentColumn = 0, 0

	if math.max(self._width, self._height) > MAX_IMAGE_SIZE then -- Compensate roblox size
		local Longest = self._width > self._height and "Width" or "Height"

		if Longest == "Width" then
			RealWidth = MAX_IMAGE_SIZE
			RealHeight = (RealWidth / self._width) * self._height
		elseif Longest == "Height" then
			RealHeight = MAX_IMAGE_SIZE
			RealWidth = (RealHeight / self._height) * self._height
		end
	else
		RealWidth, RealHeight = self._width, self._height
	end

	local FrameSize = Vector2.new((RealWidth / self._columns), (RealHeight / self._rows))
	self._object.ImageRectSize = FrameSize

	for _ = 1, self._frameAmount do
		local CurrentX = CurrentColumn * FrameSize.X
		local CurrentY = CurrentRow * FrameSize.Y

		table.insert(self._offsets, Vector2.new(CurrentX, CurrentY))

		CurrentColumn += 1

		if CurrentColumn >= self._columns then
			CurrentColumn = 0
			CurrentRow += 1
		end
	end
end

function Sprite.new(SpriteInfo: SpriteInfo): Sprite
	if SpriteInfo.ImageId ~= nil then
		SpriteInfo.ImageObject.Image = SpriteInfo.ImageId
	end

	-- Sprite should not play an ImageLabel with empty 'Image' property
	local self = setmetatable({} :: self, Sprite)

	self._object = SpriteInfo.ImageObject
	self._width = SpriteInfo.Width or 1024
	self._height = SpriteInfo.Height or 1024
	self._columns = SpriteInfo.Columns
	self._rows = SpriteInfo.Rows
	self._frameAmount = SpriteInfo.NumberOfFrames or (self._columns * self._rows)
	self._fps = SpriteInfo.FPS or 60
	self._states = {
		Playing = false,
		Cleaned = false,
	}
	self._index = 0
	self._timeInterval = self._fps and (1 / self._fps) or 0.1
	self._offsets = {}

	_Init(self)

	return self
end

function Sprite.Play(self: Sprite, play: boolean)
	if play == true then
		if self._states.Playing == true then
			warn("Failed to apply (true) to Sprite. Error: Sprite is already playing.")
			return
		end

		self._states.Playing = true

		task.spawn(function()
			while self._states.Playing == true do
				if self._states.Cleaned == true then
					break
				end
				if not self._object:IsDescendantOf(game) then
					break
				end

				self._index += 1
				self._object.ImageRectOffset = self._offsets[self._index]

				if self._index >= self._frameAmount then
					self._index = 0
				end

				task.wait(self._timeInterval)
			end
		end)
	else
		if self._states.Playing == false then
			warn("Failed to apply (false) to Sprite. Error: Sprite is already paused.")
			return
		end

		self._states.Playing = false
	end
end

function Sprite.Clean(self: Sprite)
	if self._states.Cleaned == true then
		return
	end

	self._states.Playing = false
	task.wait() -- Wait for changes to occur on the next frame
	self._states.Cleaned = true
	table.clear(self)
	setmetatable(self, nil)
end

-- // Returning
return Sprite
