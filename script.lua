local UIS = game:GetService("UserInputService")

local draggableFrame = script.Parent

local IsDragging = false 
local dragInput				
local StartingPoint
local oldPos				

local function update(input)
	local delta = input.Position - StartingPoint
	draggableFrame.Position = UDim2.new(oldPos.X.Scale, oldPos.X.Offset + delta.X, oldPos.Y.Scale, oldPos.Y.Offset + delta.Y)
end

draggableFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		IsDragging = true
		StartingPoint = input.Position
		oldPos = draggableFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				IsDragging = false
			end
		end)
	end
end)

draggableFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and IsDragging then
		update(input)
	end
end)
