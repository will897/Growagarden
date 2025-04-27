local player = game.Players.LocalPlayer
if not player then
    warn("Локальный игрок не найден.")
    return
end

local backpack = player:WaitForChild("Backpack")
local starterGear = player:WaitForChild("StarterGear")
local PlayerGui = player:WaitForChild("PlayerGui")

local seedsFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Seeds")
local prototypeSeed = backpack:FindFirstChild("Carrot Seed") or starterGear:FindFirstChild("Carrot Seed")

if not prototypeSeed then
    warn("Не найден рабочий прототип семени 'Carrot Seed'. Выдача будет ограничена.")
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.Name = "SeedGiverGUI"
ScreenGui.ResetOnSpawn = false

local button = Instance.new("TextButton")
button.Parent = ScreenGui
button.Size = UDim2.new(0, 220, 0, 50)
button.Position = UDim2.new(0.5, -110, 0.5, -25)
button.BackgroundColor3 = Color3.fromRGB(70, 180, 70)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 22
button.Text = "Выдать все семена"

-- Dragging GUI
local dragging, dragInput, dragStart, startPos
local function updateDrag(input)
    if dragging then
        local delta = input.Position - dragStart
        button.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end

button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = button.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

button.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput then
        updateDrag(input)
    end
end)

-- Список всех семян без Candy Blossom
local seeds = {
    "Carrot Seed", "Strawberry Seed", "Blueberry Seed", "Orange Tulip",
    "Tomato Seed", "Corn Seed", "Daffodil Seed", "Watermelon Seed",
    "Pumpkin Seed", "Apple Seed", "Bamboo Seed", "Coconut Seed",
    "Cactus Seed", "Dragon Fruit Seed", "Mango Seed", "Grape Seed",
    "Mushroom Seed"
}

-- Функция выдачи семян
local function giveSeed(seedName)
    local seedModel
    if seedsFolder then
        seedModel = seedsFolder:FindFirstChild(seedName)
    end

    if seedModel then
        local clone = seedModel:Clone()
        clone.Parent = backpack

        local gearClone = clone:Clone()
        gearClone.Parent = starterGear
    elseif prototypeSeed then
        local clone = prototypeSeed:Clone()
        clone.Name = seedName
        clone.Parent = backpack

        local gearClone = clone:Clone()
        gearClone.Parent = starterGear
    else
        warn("Не удалось выдать семя:", seedName)
    end
end

button.MouseButton1Click:Connect(function()
    for _, seedName in ipairs(seeds) do
        for i = 1, 10 do
            giveSeed(seedName)
        end
    end
    button.Text = "Семена выданы!"
    wait(2)
    button.Text = "Выдать все семена"
end)
