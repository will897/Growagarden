local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.Name = "SeedGiverGUI"
ScreenGui.ResetOnSpawn = false

local button = Instance.new("TextButton")
button.Parent = ScreenGui
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, -25)
button.BackgroundColor3 = Color3.fromRGB(70, 180, 70)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 24
button.Text = "Выдать все семена"

local seeds = {
    "Carrot Seed", "Strawberry Seed", "Blueberry Seed", "Orange Tulip",
    "Tomato Seed", "Corn Seed", "Daffodil Seed", "Watermelon Seed",
    "Pumpkin Seed", "Apple Seed", "Bamboo Seed", "Coconut Seed",
    "Cactus Seed", "Dragon Fruit Seed", "Mango Seed", "Grape Seed",
    "Mushroom Seed"
}

local AddItemEvent = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Inventory"):WaitForChild("AddItem")

button.MouseButton1Click:Connect(function()
    for _, seedName in ipairs(seeds) do
        for i = 1, 10 do
            AddItemEvent:FireServer(seedName, 1)
        end
    end
    button.Text = "Семена выданы!"
    wait(2)
    button.Text = "Выдать все семена"
end)
