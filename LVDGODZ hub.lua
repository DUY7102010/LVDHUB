local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "LVDGODZ_GUI"
gui.ResetOnSpawn = false

local toggleButton = Instance.new("TextButton", gui)
toggleButton.Size = UDim2.new(0, 100, 0, 40)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleButton.Text = "LVDGODZ"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 18
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", toggleButton)

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BackgroundTransparency = 0.3
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(85, 170, 255)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true
Instance.new("UICorner", mainFrame)

local isMinimized = false
toggleButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    mainFrame.Visible = not isMinimized
end)

-- Tabs
local tabBar = Instance.new("Frame", mainFrame)
tabBar.Size = UDim2.new(1, 0, 0, 20)
tabBar.Position = UDim2.new(0, 0, 0, 0)
tabBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tabBar.BorderSizePixel = 0

local tabFrames = {}
local currentTab = 1

for i = 1, 3 do
    local tabLabel = Instance.new("TextButton", tabBar)
    tabLabel.Name = "Tab" .. i
    tabLabel.Size = UDim2.new(1/3, 0, 1, 0)
    tabLabel.Position = UDim2.new((i-1)/3, 0, 0, 0)
    tabLabel.Text = "Tab " .. i
    tabLabel.Font = Enum.Font.GothamBold
    tabLabel.TextSize = 14
    tabLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    tabLabel.BackgroundTransparency = 1

    local tabFrame = Instance.new("Frame", mainFrame)
    tabFrame.Size = UDim2.new(1, 0, 1, -20)
    tabFrame.Position = UDim2.new(0, 0, 0, 20)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = (i == 1)
    tabFrames[i] = tabFrame

    tabLabel.MouseButton1Click:Connect(function()
        currentTab = i
        for j, frame in ipairs(tabFrames) do
            frame.Visible = (j == i)
        end
    end)
end

-- Vuốt để chuyển tab
local swipeStartX = nil
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        swipeStartX = input.Position.X
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and swipeStartX then
        local deltaX = input.Position.X - swipeStartX
        if math.abs(deltaX) > 50 then
            if deltaX < 0 and currentTab < #tabFrames then
                currentTab += 1
            elseif deltaX > 0 and currentTab > 1 then
                currentTab -= 1
            end
            for i, frame in ipairs(tabFrames) do
                frame.Visible = (i == currentTab)
            end
        end
        swipeStartX = nil
    end
end)

local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local fruitColors = {
    ["Dragon Fruit"] = Color3.fromRGB(255,0,0),
    ["Leopard Fruit"] = Color3.fromRGB(255,85,0),
    ["Dough Fruit"] = Color3.fromRGB(255,170,0),
    ["Light Fruit"] = Color3.fromRGB(255,255,0),
    ["Flame Fruit"] = Color3.fromRGB(255,100,0),
    ["Bomb Fruit"] = Color3.fromRGB(200,200,200),
}

function createFruitESP(obj)
    if not obj:IsA("Tool") or not obj:FindFirstChild("Handle") then return end
    if obj.Handle:FindFirstChild("ESP") then return end

    local gui = Instance.new("BillboardGui")
    gui.Name = "ESP"
    gui.Size = UDim2.new(0,100,0,40)
    gui.AlwaysOnTop = true
    gui.StudsOffset = Vector3.new(0,2,0)
    gui.Adornee = obj.Handle
    gui.Parent = obj.Handle

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = "🍒 "..obj.Name
    label.TextColor3 = fruitColors[obj.Name] or Color3.new(1,1,1)
    label.TextScaled = true
    label.TextStrokeTransparency = 0
    label.Font = Enum.Font.SourceSansBold
    label.Parent = gui

    RunService.RenderStepped:Connect(function()
        if obj and obj.Parent and obj:FindFirstChild("Handle") then
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local distance = hrp and (obj.Handle.Position - hrp.Position).Magnitude or 0
            label.Text = string.format("🍒 %s\n📏 %.0f m", obj.Name, distance)
        else
            gui:Destroy()
        end
    end)
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

function createPlayerESP(player)
    if player == LocalPlayer then return end
    local character = player.Character
    if not character or not character:FindFirstChild("Head") or not character:FindFirstChildOfClass("Humanoid") then return end
    local head = character.Head
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if head:FindFirstChild("PlayerESP") then return end

    local gui = Instance.new("BillboardGui")
    gui.Name = "PlayerESP"
    gui.Size = UDim2.new(0, 150, 0, 50)
    gui.AlwaysOnTop = true
    gui.StudsOffset = Vector3.new(0, 2.5, 0)
    gui.Adornee = head
    gui.Parent = head

    local nameLabel = Instance.new("TextLabel", gui)
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold

    local infoLabel = Instance.new("TextLabel", gui)
    infoLabel.Size = UDim2.new(1, 0, 0.5, 0)
    infoLabel.Position = UDim2.new(0, 0, 0.5, 0)
    infoLabel.BackgroundTransparency = 1
    infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoLabel.TextStrokeTransparency = 0
    infoLabel.TextScaled = true
    infoLabel.Font = Enum.Font.Gotham

    RunService.RenderStepped:Connect(function()
        if character and character:FindFirstChild("HumanoidRootPart") and humanoid and humanoid.Health > 0 then
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local distance = hrp and (character.HumanoidRootPart.Position - hrp.Position).Magnitude or 0
            infoLabel.Text = string.format("❤️ %.0f HP\n📏 %.0f m", humanoid.Health, distance)
        else
            gui:Destroy()
        end
    end)
end

-- Tạo ESP cho tất cả người chơi hiện tại
for _, player in pairs(Players:GetPlayers()) do
    createPlayerESP(player)
end

-- Tạo ESP khi người chơi mới vào
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(1)
        createPlayerESP(player)
    end)
end)

-- Tạo lại ESP khi nhân vật respawn
for _, player in pairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(function()
        wait(1)
        createPlayerESP(player)
    end)
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Trạng thái
local isAimbotActive = false
local isRightMouseDown = false
local lockedTarget = nil
local followingMouse = false
local followStartTime = 0
local dragging = false
local dragOffset = Vector2.new()

-- Tạo GUI siêu nhỏ
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "TinyAimbotGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 10, 0, 10)
button.AnchorPoint = Vector2.new(0.5, 0.5)
button.Position = UDim2.new(0.5, 0, 0.5, 0)
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
button.BorderSizePixel = 0
button.Text = ""
button.Active = true
button.Draggable = false

-- Bật/tắt Aimbot
button.MouseButton1Click:Connect(function()
    isAimbotActive = not isAimbotActive
    button.BackgroundColor3 = isAimbotActive and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    lockedTarget = nil

    if isAimbotActive then
        followingMouse = true
        followStartTime = tick()
    end
end)

-- Theo chuột trong 2 giây đầu
RunService.RenderStepped:Connect(function()
    if followingMouse then
        local mousePos = UIS:GetMouseLocation()
        button.Position = UDim2.new(0, mousePos.X, 0, mousePos.Y)

        if tick() - followStartTime >= 2 then
            followingMouse = false
        end
    end
end)

-- Kéo nút bằng chuột trái
button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragOffset = Vector2.new(input.Position.X, input.Position.Y) - Vector2.new(button.Position.X.Offset, button.Position.Y.Offset)
    end
end)

button.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local newPos = Vector2.new(input.Position.X, input.Position.Y) - dragOffset
        button.Position = UDim2.new(0, newPos.X, 0, newPos.Y)
    end
end)

-- Theo chuột phải
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isRightMouseDown = true
    end
end)

UIS.InputEnded:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isRightMouseDown = false
    end
end)

-- Tìm người chơi gần nhất
local function getClosestPlayer()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local closest, shortest = nil, math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local root = plr.Character.HumanoidRootPart
            local hum = plr.Character:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 then
                local dist = (root.Position - hrp.Position).Magnitude
                if dist < shortest then
                    closest = root
                    shortest = dist
                end
            end
        end
    end
    return closest
end

-- Aimbot logic
RunService.RenderStepped:Connect(function()
    if isAimbotActive and not isRightMouseDown then
        if not lockedTarget or not lockedTarget.Parent or (lockedTarget.Parent:FindFirstChild("Humanoid") and lockedTarget.Parent.Humanoid.Health <= 0) then
            lockedTarget = getClosestPlayer()
        end
        if lockedTarget then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, lockedTarget.Position)
        end
    end
end)

