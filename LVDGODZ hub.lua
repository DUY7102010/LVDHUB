-- Dịch vụ
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId
local Speed = 700
local ScanInterval = 2
local daXuLy = {}

-- GUI chính
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "LVDGODZ_GUI"
gui.ResetOnSpawn = false

-- Nút thu nhỏ
local toggleButton = Instance.new("TextButton", gui)
toggleButton.Size = UDim2.new(0, 100, 0, 40)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleButton.Text = "LVDGODZ"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 18
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", toggleButton)

-- Hiệu ứng màu
task.spawn(function()
    local colors = {
        Color3.fromRGB(255, 85, 85),
        Color3.fromRGB(85, 255, 170),
        Color3.fromRGB(85, 170, 255),
        Color3.fromRGB(255, 255, 85)
    }
    local i = 1
    while toggleButton do
        toggleButton.TextColor3 = colors[i]
        i = i % #colors + 1
        wait(0.8)
    end
end)

-- Khung chính
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

-- Toggle GUI
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
        for j, frame in ipairs(tabFrames) do
            frame.Visible = (j == i)
        end
    end)
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function createPlayerESP(player)
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
-- Auto bay nhặt trái
local autoFruitButton = Instance.new("TextButton", tabFrames[2])
autoFruitButton.Size = UDim2.new(0, 200, 0, 40)
autoFruitButton.Position = UDim2.new(0, 20, 0, 80)
autoFruitButton.Text = "Auto bay nhặt trái"
autoFruitButton.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
Instance.new("UICorner", autoFruitButton)

autoFruitButton.MouseButton1Click:Connect(function()
    task.spawn(function()
        while true do
            for _, obj in pairs(workspace:GetChildren()) do
                if obj:IsA("Tool") and obj:FindFirstChild("Handle") and not daXuLy[obj] then
                    daXuLy[obj] = true
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local targetPos = obj.Handle.Position + Vector3.new(0, 5, 0)
                        local distance = (hrp.Position - targetPos).Magnitude
                        local tweenInfo = TweenInfo.new(distance / Speed, Enum.EasingStyle.Linear)
                        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(targetPos)})
                        tween:Play()
                        repeat task.wait(1) until not obj.Parent or obj.Parent == LocalPlayer.Backpack
                        task.wait(10)
                    end
                end
            end
            task.wait(ScanInterval)
        end
    end)
end)

-- Hop Server VIP
local hopButton = Instance.new("TextButton", tabFrames[2])
hopButton.Size = UDim2.new(0, 200, 0, 40)
hopButton.Position = UDim2.new(0, 20, 0, 140)
hopButton.Text = "Hop Server VIP"
hopButton.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
Instance.new("UICorner", hopButton)

hopButton.MouseButton1Click:Connect(function()
    local success, result = pcall(function()
        return HttpService:JSONDecode(
            game:HttpGet("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
        )
    end)
    if success and result and result.data then
        local minPlayers = math.huge
        local targetServer = nil
        for _, server in pairs(result.data) do
        if server.playing < minPlayers and server.id ~= game.JobId then
            minPlayers = server.playing
            targetServer = server.id
        end
    end
    if targetServer then
        TeleportService:TeleportToPlaceInstance(PlaceId, targetServer, LocalPlayer)
    end
end
end)

-- Tab 3: Nút mở GUI Aimbot
local aimbotButton = Instance.new("TextButton", tabFrames[3])
aimbotButton.Size = UDim2.new(0, 200, 0, 40)
aimbotButton.Position = UDim2.new(0, 20, 0, 20)
aimbotButton.Text = "Mở GUI Aimbot"
aimbotButton.BackgroundColor3 = Color3.fromRGB(170, 85, 255)
Instance.new("UICorner", aimbotButton)

-- GUI phụ Aimbot
local aimbotGui = Instance.new("Frame", gui)
aimbotGui.Size = UDim2.new(0, 300, 0, 150)
aimbotGui.Position = UDim2.new(0.5, -150, 0.5, -75)
aimbotGui.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
aimbotGui.BorderSizePixel = 2
aimbotGui.BorderColor3 = Color3.fromRGB(170, 85, 255)
aimbotGui.Visible = false
aimbotGui.Active = true
aimbotGui.Draggable = true
Instance.new("UICorner", aimbotGui)

local aimbotToggle = Instance.new("TextButton", aimbotGui)
aimbotToggle.Size = UDim2.new(0, 200, 0, 40)
aimbotToggle.Position = UDim2.new(0.5, -100, 0.5, -20)
aimbotToggle.Text = "Bật Aimbot"
aimbotToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
aimbotToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
Instance.new("UICorner", aimbotToggle)

local aimbotActive = false
aimbotToggle.MouseButton1Click:Connect(function()
    aimbotActive = not aimbotActive
    aimbotToggle.Text = aimbotActive and "Tắt Aimbot" or "Bật Aimbot"
    -- Gắn logic aimbot tại đây nếu có
end)

aimbotButton.MouseButton1Click:Connect(function()
    aimbotGui.Visible = not aimbotGui.Visible
end)
