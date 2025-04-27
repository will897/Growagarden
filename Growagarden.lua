local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local starterGear = player:WaitForChild("StarterGear")
local replicatedStorage = game:GetService("ReplicatedStorage")
local seedsFolder = replicatedStorage:WaitForChild("Seed")

local seeds = {
    "Carrot Seed", "Strawberry Seed", "Blueberry Seed", "Orange Tulip",
    "Tomato Seed", "Corn Seed", "Daffodil Seed", "Watermelon Seed",
    "Pumpkin Seed", "Apple Seed", "Bamboo Seed", "Coconut Seed",
    "Cactus Seed", "Dragon Fruit Seed", "Mango Seed", "Grape Seed",
    "Mushroom Seed", "Candy Blossom" -- Candy Blossom тоже тут
}

-- GUI
local PlayerGui = player:WaitForChild("PlayerGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.Name = "SeedGiverGui"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 270, 0, 70)
Frame.Position = UDim2.new(0.5, -135, 0.7, 0)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Active = true
Frame.Draggable = true -- Самое важное для перетаскивания

local button = Instance.new("TextButton")
button.Parent = Frame
button.Size = UDim2.new(1, -20, 1, -20)
button.Position = UDim2.new(0, 10, 0, 10)
button.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 22
button.Text = "Выдать 10x всех семян"

-- Функция выдачи настоящих семян
local function giveRealSeed(seedName)
    local seedTemplate = seedsFolder:FindFirstChild(seedName)
    if seedTemplate then
        local clone = seedTemplate:Clone()
        clone.Parent = backpack

        -- Для сохранения после смерти
        local clone2 = seedTemplate:Clone()
        clone2.Parent = starterGear
    else
        warn("Семя не найдено в папке Seed: " .. seedName)
    end
end

-- Выдача при нажатии
button.MouseButton1Click:Connect(function()
    for _, seedName in ipairs(seeds) do
        for i = 1, 10 do
            giveRealSeed(seedName)
        end
    end
    button.Text = "Семена выданы!"
    wait(2)
    button.Text = "Выдать 10x всех семян"
end)
