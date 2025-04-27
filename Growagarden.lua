local player = game.Players.LocalPlayer
if not player then
    warn("Локальный игрок не найден.")
    return
end

local PlayerGui = player:WaitForChild("PlayerGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.Name = "GrowAGardenDuplication"
ScreenGui.ResetOnSpawn = false

local Dragging = nil
local DragInput = nil
local DragStart = nil
local StartPosition = nil

local function Update(input)
    if Dragging then
        local Delta = input.Position - DragStart
        ScreenGui.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
end

local function Drag(input)
    Dragging = true
    DragStart = input.Position
    StartPosition = ScreenGui.Position

    input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
            Dragging = false
        end
    end)
end

ScreenGui.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        DragInput = input
        Drag(input)
    end
end)

ScreenGui.InputChanged:Connect(function(input)
    if input == DragInput then
        Update(input)
    end
end)

local TextButton = Instance.new("TextButton")
TextButton.Parent = ScreenGui
TextButton.Size = UDim2.new(0, 200, 0, 50)
TextButton.Position = UDim2.new(0.5, -100, 0.5, -25) -- Позиция в центре экрана
TextButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
TextButton.TextColor3 = Color3.new(1, 1, 1)
TextButton.Font = Enum.Font.SourceSansBold
TextButton.TextSize = 24
TextButton.Text = "Дюпнуть бамбук"

local cooldown = false
local seeds = {"Bamboo Seed"}
local cooldownTime = 10 -- Задержка 10 секунд

TextButton.MouseButton1Click:Connect(function()
    if cooldown then
        TextButton.Text = "Жди " .. cooldownTime .. " сек!"
        return
    end

    cooldown = true
    TextButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)

    local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Inventory"):WaitForChild("AddItem")
    if not RemoteEvent then
        warn("Ошибка: RemoteEvent 'AddItem' не найден!")
        TextButton.Text = "Ошибка дюпа!"
        cooldown = true
        return
    end

    local success, err = pcall(function()
        for _, seedName in pairs(seeds) do
            RemoteEvent:FireServer(seedName, 1)
        end
    end)

    if not success then
        warn("Ошибка при дюпе бамбука:", err)
    end

    TextButton.Text = "Подождите " .. cooldownTime .. " сек..."
    wait(cooldownTime)
    TextButton.Text = "Дюпнуть бамбук"
    TextButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    cooldown = false
end)
