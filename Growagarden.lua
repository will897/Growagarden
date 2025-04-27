local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.Name = "SeedGiverReal"
ScreenGui.ResetOnSpawn = false

local button = Instance.new("TextButton")
button.Parent = ScreenGui
button.Size = UDim2.new(0, 250, 0, 60)
button.Position = UDim2.new(0.5, -125, 0.5, -30)
button.BackgroundColor3 = Color3.fromRGB(70, 180, 70)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 24
button.Text = "Выдать все семена"

-- Список настоящих семян
local seeds = {
    "Carrot Seed", "Strawberry Seed", "Blueberry Seed", "Orange Tulip",
    "Tomato Seed", "Corn Seed", "Daffodil Seed", "Watermelon Seed",
    "Pumpkin Seed", "Apple Seed", "Bamboo Seed", "Coconut Seed",
    "Cactus Seed", "Dragon Fruit Seed", "Mango Seed", "Grape Seed",
    "Mushroom Seed"
}

local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Inventory"):WaitForChild("AddItem")

button.MouseButton1Click:Connect(function()
    button.Text = "Выдача семян..."
    for _, seedName in ipairs(seeds) do
        for i = 1, 10 do
            RemoteEvent:FireServer(seedName, 1)
            wait(0.05) -- Небольшая пауза чтобы сервер успевал обрабатывать
        end
    end
    button.Text = "Семена выданы!"
    wait(2)
    button.Text = "Выдать все семена"
end)
