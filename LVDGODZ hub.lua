-- INTRO GUI: LVDGODZ
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = Lighting

local IntroGui = Instance.new("ScreenGui", PlayerGui)
IntroGui.Name = "IntroLVD"
IntroGui.IgnoreGuiInset = true
IntroGui.ResetOnSpawn = false

local Background = Instance.new("Frame", IntroGui)
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(5, 5, 10)

local Gradient = Instance.new("UIGradient", Background)
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 25)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 25, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 25))
}
Gradient.Rotation = 45

local Glow = Instance.new("ImageLabel", Background)
Glow.Size = UDim2.new(1.5, 0, 1.5, 0)
Glow.Position = UDim2.new(-0.25, 0, -0.25, 0)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://9150630156"
Glow.ImageColor3 = Color3.fromRGB(90, 130, 255)
Glow.ImageTransparency = 0.85
Glow.ZIndex = 0

local Text = Instance.new("TextLabel", Background)
Text.AnchorPoint = Vector2.new(0.5, 0.5)
Text.Position = UDim2.new(0.5, 0, 0.5, 0)
Text.Size = UDim2.new(1, 0, 0.25, 0)
Text.Text = "LVDGODZ"
Text.TextColor3 = Color3.fromRGB(230, 235, 255)
Text.TextTransparency = 1
Text.TextScaled = true
Text.Font = Enum.Font.GothamBold
Text.ZIndex = 3
Text.BackgroundTransparency = 1

local Stroke = Instance.new("UIStroke", Text)
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(120, 150, 255)
Stroke.Transparency = 0.3
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local Shine = Instance.new("ImageLabel", Background)
Shine.AnchorPoint = Vector2.new(0.5, 0.5)
Shine.Position = UDim2.new(0.5, 0, 0.5, 0)
Shine.Size = UDim2.new(2, 0, 3, 0)
Shine.BackgroundTransparency = 1
Shine.Image = "rbxassetid://9150641010"
Shine.ImageColor3 = Color3.fromRGB(100, 130, 255)
Shine.ImageTransparency = 0.9
Shine.ZIndex = 2

TweenService:Create(Blur, TweenInfo.new(2), {Size = 25}):Play()
TweenService:Create(Text, TweenInfo.new(2), {TextTransparency = 0}):Play()
TweenService:Create(Stroke, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.5}):Play()
TweenService:Create(Shine, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {ImageTransparency = 0.7}):Play()
TweenService:Create(Glow, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {ImageTransparency = 0.75}):Play()

task.delay(4, function()
    TweenService:Create(Text, TweenInfo.new(2), {TextTransparency = 1}):Play()
    TweenService:Create(Background, TweenInfo.new(2), {BackgroundTransparency = 1}):Play()
    TweenService:Create(Blur, TweenInfo.new(2), {Size = 0}):Play()
    task.delay(2.2, function()
        IntroGui:Destroy()
        Blur:Destroy()
    end)
end)


-- 📦 Dịch vụ Roblox
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 🧰 Helpers
local function safeGetCharacterHumanoidRootPart()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart")
    return hrp
end

-- ESP trái cây
local function createFruitESP(object)
    if not object or not object:IsDescendantOf(workspace) then return end
    if object:IsA("Tool") then
        local handle = object:FindFirstChild("Handle")
        if handle and not handle:FindFirstChild("LVDGODZ_FruitESP") then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "LVDGODZ_FruitESP"
            billboard.Size = UDim2.new(0, 80, 0, 30)
            billboard.AlwaysOnTop = true
            billboard.LightInfluence = 0
            billboard.MaxDistance = 10000
            billboard.Parent = handle

            local label = Instance.new("TextLabel", billboard)
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Text = object.Name
            label.TextColor3 = Color3.fromRGB(255, 255, 0)
            label.Font = Enum.Font.GothamBold
            label.TextScaled = true
        end
    end
end

-- ESP player
local function createPlayerESP(plr)
    if plr == LocalPlayer then return end
    local char = plr.Character or plr.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hrp:FindFirstChild("LVDGODZ_PlayerESP") then return end

    local billboard = Instance.new("BillboardGui", hrp)
    billboard.Name = "LVDGODZ_PlayerESP"
    billboard.Size = UDim2.new(0, 100, 0, 30)
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 3, 0)

    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    local dist = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position) and (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude or 0
    label.Text = plr.Name .. " (" .. math.floor(dist) .. "m) HP:" .. math.floor(hum and hum.Health or 0)
    label.TextColor3 = Color3.fromRGB(0, 255, 0)
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
end

-- 🖥️ GUI chính
local gui = Instance.new("ScreenGui", PlayerGui)
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

-- Rainbow chữ LVDGODZ
task.spawn(function()
    while true do
        local t = tick() % 5 / 5
        toggleButton.TextColor3 = Color3.fromHSV(t, 1, 1)
        task.wait(0.1)
    end
end)

-- ScrollingFrame
local mainFrame = Instance.new("ScrollingFrame", gui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BackgroundTransparency = 0.3
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(85, 170, 255)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.ClipsDescendants = true
mainFrame.CanvasSize = UDim2.new(0,0,0,0)
mainFrame.ScrollBarThickness = 8
Instance.new("UICorner", mainFrame)

-- Toggle hiển thị với Tween
local isMinimized = true
local function animateGui(open)
    local goal = {}
    if open then
        goal.Size = UDim2.new(0, 500, 0, 300)
        goal.Position = UDim2.new(0.5, -250, 0.5, -150)
    else
        goal.Size = UDim2.new(0, 0, 0, 0)
        goal.Position = UDim2.new(0.5, 0, 0.5, 0)
    end
    local tween = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), goal)
    tween:Play()
end

toggleButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    animateGui(not isMinimized)
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
    tabLabel.BackgroundColor3 = (i==1) and Color3.fromRGB(100,100,100) or Color3.fromRGB(200,200,200)
    tabLabel.TextColor3 = (i==1) and Color3.fromRGB(255,255,255) or Color3.fromRGB(0,0,0)

    local underline = Instance.new("Frame", tabLabel)
    underline.Size = UDim2.new(1,0,0,2)
    underline.Position = UDim2.new(0,0,1,-2)
    underline.BackgroundColor3 = Color3.fromRGB(255,255,255)
    underline.Visible = (i==1)

    local tabFrame = Instance.new("Frame", mainFrame)
    tabFrame.Size = UDim2.new(1, 0, 1, -20)
    tabFrame.Position = UDim2.new(0, 0, 0, 20)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = (i == 1)
    tabFrames[i] = tabFrame

    -- ensure layout exists for each tab so children stack vertically
    local layout = Instance.new("UIListLayout", tabFrame)
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        if tabFrame.Visible then
            mainFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 40)
        end
    end)

    tabLabel.MouseButton1Click:Connect(function()
        currentTab = i
        for j, frame in ipairs(tabFrames) do
            frame.Visible = (j == i)
            local tabBtn = tabBar:FindFirstChild("Tab"..j)
            if tabBtn then
                tabBtn.BackgroundColor3 = (j==i) and Color3.fromRGB(100,100,100) or Color3.fromRGB(200,200,200)
                tabBtn.TextColor3 = (j==i) and Color3.fromRGB(255,255,255) or Color3.fromRGB(0,0,0)
                local underlineFrame = tabBtn:FindFirstChildOfClass("Frame")
                if underlineFrame then
                    underlineFrame.Visible = (j==i)
                end
            end
        end
        -- update canvas for new visible tab (defer to allow layout to compute)
        task.defer(function()
            task.wait(0.02)
            local visibleLayout = tabFrames[currentTab]:FindFirstChildOfClass("UIListLayout")
            if visibleLayout then
                mainFrame.CanvasSize = UDim2.new(0, 0, 0, visibleLayout.AbsoluteContentSize.Y + 40)
            end
        end)
    end)
end

-- Helper to create standard full-width button
local function createButton(parent, text, layoutOrder)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -40, 0, 40)
    btn.LayoutOrder = layoutOrder
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn)
    return btn
end

-- TAB 1: San Sea + Fly/Noclip/Speed + ESP Player
do
    local order = 1

    local sanSeaBtn = createButton(tabFrames[1], "⚙️ Bật script San Sea", order); order = order + 1
    sanSeaBtn.MouseButton1Click:Connect(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DUY7102010/san-sea/refs/heads/main/san-sea.lua"))()
        end)
        if not ok then warn("Không tải được San Sea: " .. tostring(err)) end
    end)

    -- ✈️ Fly với nút tăng/giảm tốc độ
    local flying = false
    local flySpeed = 50
    local flyBtn = createButton(tabFrames[1], "✈️ Fly", order); order = order + 1

    local speedFrame -- container for minus/speed/plus
    local flyConn -- store RenderStepped connection so we can disconnect
    flyBtn.MouseButton1Click:Connect(function()
        flying = not flying
        if flying then
            flyBtn.Text = "✈️ Fly (ON)"
            local hrp = safeGetCharacterHumanoidRootPart()
            if not hrp then return end

            -- ensure existing BV removed
            for _, v in pairs(hrp:GetChildren()) do
                if v:IsA("BodyVelocity") and v.Name=="LVDGODZ_FlyBV" then
                    v:Destroy()
                end
            end

            local bv = Instance.new("BodyVelocity")
            bv.Name = "LVDGODZ_FlyBV"
            bv.MaxForce = Vector3.new(1e5,1e5,1e5)
            bv.Parent = hrp

            -- avoid creating duplicate UI controls
            if speedFrame and speedFrame.Parent then speedFrame:Destroy() end

            -- tạo container ngang cho nút chỉnh tốc độ
            speedFrame = Instance.new("Frame", tabFrames[1])
            speedFrame.Size = UDim2.new(1, -40, 0, 40)
            speedFrame.LayoutOrder = order; order = order + 1
            speedFrame.BackgroundTransparency = 1

            local hLayout = Instance.new("UIListLayout", speedFrame)
            hLayout.FillDirection = Enum.FillDirection.Horizontal
            hLayout.SortOrder = Enum.SortOrder.LayoutOrder
            hLayout.Padding = UDim.new(0,8)

            local minusBtn = Instance.new("TextButton", speedFrame)
            minusBtn.Size = UDim2.new(0,40,0,40)
            minusBtn.LayoutOrder = 1
            minusBtn.Text = "-"
            Instance.new("UICorner", minusBtn)

            local speedLabel = Instance.new("TextLabel", speedFrame)
            speedLabel.Size = UDim2.new(0,80,0,40)
            speedLabel.LayoutOrder = 2
            speedLabel.Text = tostring(flySpeed)
            speedLabel.BackgroundTransparency = 1
            speedLabel.TextColor3 = Color3.new(1,1,1)
            speedLabel.TextScaled = true

            local plusBtn = Instance.new("TextButton", speedFrame)
            plusBtn.Size = UDim2.new(0,40,0,40)
            plusBtn.LayoutOrder = 3
            plusBtn.Text = "+"
            Instance.new("UICorner", plusBtn)

            minusBtn.MouseButton1Click:Connect(function()
                flySpeed = math.max(10, flySpeed-10)
                if speedLabel then speedLabel.Text = tostring(flySpeed) end
            end)
            plusBtn.MouseButton1Click:Connect(function()
                flySpeed = flySpeed+10
                if speedLabel then speedLabel.Text = tostring(flySpeed) end
            end)

            -- loop bay (store connection)
            flyConn = RunService.RenderStepped:Connect(function()
                if flying and hrp and hrp:FindFirstChild("LVDGODZ_FlyBV") then
                    local move = Vector3.new()
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += Camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= Camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= Camera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += Camera.CFrame.RightVector end
                    hrp.LVDGODZ_FlyBV.Velocity = move.Magnitude>0 and move.Unit*flySpeed or Vector3.zero
                end
            end)
        else
            flyBtn.Text = "✈️ Fly"
            -- xoá BodyVelocity khi tắt
            local hrp = safeGetCharacterHumanoidRootPart()
            if hrp then
                for _, v in pairs(hrp:GetChildren()) do
                    if v:IsA("BodyVelocity") and v.Name=="LVDGODZ_FlyBV" then
                        v:Destroy()
                    end
                end
            end
            if speedFrame then speedFrame:Destroy() speedFrame = nil end
            if flyConn then flyConn:Disconnect() flyConn = nil end
        end
    end)

    -- 🚪 Noclip
    local noclipEnabled = false
    local noclipButton = createButton(tabFrames[1], "🚪 Noclip", order); order = order + 1

    local noclipConn
    noclipButton.MouseButton1Click:Connect(function()
        noclipEnabled = not noclipEnabled
        noclipButton.Text = noclipEnabled and "🚪 Noclip (ON)" or "🚪 Noclip"
        if noclipEnabled then
            if noclipConn then noclipConn:Disconnect() noclipConn = nil end
            noclipConn = RunService.Stepped:Connect(function()
                if noclipEnabled and LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConn then noclipConn:Disconnect() noclipConn = nil end
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end)

    -- 👤 ESP Player
    local espPlayerBtn = createButton(tabFrames[1], "👤 Bật ESP Player", order); order = order + 1
    espPlayerBtn.MouseButton1Click:Connect(function()
        for _, plr in pairs(Players:GetPlayers()) do
            createPlayerESP(plr)
        end
    end)
end


-- TAB 2: Nhặt trái & ESP trái cây
-- 🍒 Auto Collect Fruit (ON/OFF)
local autoCollectEnabled = false

-- Hàm tele trái cây về nhân vật
local function teleFruit(obj)
    local hrp = safeGetCharacterHumanoidRootPart()
    if not hrp then return end
    if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
        task.defer(function()
            obj.Handle.CFrame = hrp.CFrame
        end)
    end
end

do
    local order = 1
    local collectBtn = createButton(tabFrames[2], "🍒 Auto Collect: OFF", order); order = order + 1
    collectBtn.MouseButton1Click:Connect(function()
        autoCollectEnabled = not autoCollectEnabled
        if autoCollectEnabled then
            collectBtn.Text = "🍒 Auto Collect: ON"
            collectBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
            game.StarterGui:SetCore("SendNotification",{Title="AUTO COLLECT";Text="Enabled";Duration=2})
            local hrp = safeGetCharacterHumanoidRootPart()
            if hrp then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                        obj.Handle.CFrame = hrp.CFrame
                    end
                end
            end
        else
            collectBtn.Text = "🍒 Auto Collect: OFF"
            collectBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
            game.StarterGui:SetCore("SendNotification",{Title="AUTO COLLECT";Text="Disabled";Duration=2})
        end
    end)

    local espBtn = createButton(tabFrames[2], "👁️ Bật ESP trái cây", order); order = order + 1
    espBtn.MouseButton1Click:Connect(function()
        for _, obj in pairs(workspace:GetChildren()) do
            createFruitESP(obj)
        end
    end)

    -- Nút God Mode
    local godModeBtn = createButton(tabFrames[2], "💀 Bật God Mode", order); order = order + 1
    local godModeEnabled = false
    local connection

    godModeBtn.MouseButton1Click:Connect(function()
        godModeEnabled = not godModeEnabled
        if godModeEnabled then
            godModeBtn.Text = "💀 God Mode: ON"
            godModeBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)

            connection = RunService.Heartbeat:Connect(function()
                local character = LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.MaxHealth = math.huge
                        humanoid.Health = math.huge
                    end
                end
            end)

            LocalPlayer.CharacterAdded:Connect(function(char)
                local humanoid = char:WaitForChild("Humanoid")
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
                humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                    humanoid.MaxHealth = math.huge
                    humanoid.Health = math.huge
                end)
            end)
        else
            godModeBtn.Text = "💀 God Mode: OFF"
            godModeBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
            if connection then
                connection:Disconnect()
                connection = nil
            end
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.MaxHealth = 100
                    humanoid.Health = 100
                end
            end
        end
    end)

    -- AutoFarm button
    local autoFarmBtn = createButton(tabFrames[2], "🍇 Auto Farm: OFF", order); order = order + 1
    autoFarmBtn.MouseButton1Click:Connect(function()
        _G.AutoFarmEnabled = not _G.AutoFarmEnabled
        if _G.AutoFarmEnabled then
            autoFarmBtn.Text = "🍇 Auto Farm: ON"
            autoFarmBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
            game.StarterGui:SetCore("SendNotification",{Title="AUTO FARM";Text="Enabled";Duration=2})
            startAutoFarm()
        else
            autoFarmBtn.Text = "🍇 Auto Farm: OFF"
            autoFarmBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
            game.StarterGui:SetCore("SendNotification",{Title="AUTO FARM";Text="Disabled";Duration=2})
            resetFarm()
        end
    end)
end

-- =========================
-- Core farming logic (unchanged)
-- =========================
if _G.AutoFarm then
    warn("Script đã chạy! Không thể chạy lại.")
    return
end
_G.AutoFarm = true
_G.AutoFarmEnabled = false -- mặc định tắt

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EnemiesFolder = workspace:WaitForChild("Enemies")
local Net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")

local function getHRP()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function isEnemyAlive(enemyPart)
    if not enemyPart then return false end
    local model = enemyPart.Parent
    if model and model:FindFirstChild("Humanoid") then
        local hum = model.Humanoid
        return hum.Health > 0
    end
    return false
end

local function getEnemyInRange(maxRange)
    local hrp = getHRP()
    if not hrp then return nil end
    local closest, shortest = nil, maxRange
    for _, enemy in pairs(EnemiesFolder:GetChildren()) do
        local part = enemy:FindFirstChild("HumanoidRootPart") or enemy:FindFirstChild("UpperTorso") or enemy:FindFirstChild("Head")
        if part and part:IsA("BasePart") and isEnemyAlive(part) then
            local d = (part.Position - hrp.Position).Magnitude
            if d < shortest then
                shortest = d
                closest = part
            end
        end
    end
    return closest
end

local function gatherEnemiesInstant(maxRange)
    local hrp = getHRP()
    if not hrp then return end

    local nearest = getEnemyInRange(maxRange or 300)
    if not nearest then return end

    local pointA = nearest.Position
    local pointB = pointA + Vector3.new(0,20,0)
    hrp.CFrame = CFrame.new(pointB)

    for _, enemy in pairs(EnemiesFolder:GetChildren()) do
        local part = enemy:FindFirstChild("HumanoidRootPart") or enemy:FindFirstChild("UpperTorso") or enemy:FindFirstChild("Head")
        if part and part:IsA("BasePart") and isEnemyAlive(part) then
            local d = (part.Position - hrp.Position).Magnitude
            if d <= (maxRange or 300) then
                local bv = part:FindFirstChild("FarmBV")
                if not bv then
                    bv = Instance.new("BodyVelocity")
                    bv.Name = "FarmBV"
                    bv.MaxForce = Vector3.new(1e5,1e5,1e5)
                    bv.Parent = part
                end
                local dir = (pointA - part.Position)
                if dir.Magnitude > 0 then
                    bv.Velocity = dir.Unit * 9999
                else
                    bv.Velocity = Vector3.new(0,0,0)
                end
            end
        end
    end
end

local function resetFarm()
    for _, enemy in pairs(EnemiesFolder:GetChildren()) do
        local part = enemy:FindFirstChild("HumanoidRootPart") or enemy:FindFirstChild("UpperTorso") or enemy:FindFirstChild("Head")
        if part then
            local bv = part:FindFirstChild("FarmBV")
            if bv then bv:Destroy() end
            local bp = part:FindFirstChild("FarmBP")
            if bp then bp:Destroy() end
        end
    end
    local hrp = getHRP()
    if hrp then
        local bv = hrp:FindFirstChild("FarmFloatBV")
        if bv then bv:Destroy() end
    end
end

local function registerHitNPC(targetPart)
    if targetPart then
        Net:WaitForChild("RE/RegisterHit"):FireServer(targetPart, {}, "3269aee8")
    end
end

local function attackAllPlayers()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local args = {
                [1] = player.Character.Head,
                [2] = {},
                [4] = "326880d6"
            }
            Net:WaitForChild("RE/RegisterHit"):FireServer(unpack(args))
        end
    end
end

local function scanAndMove()
    local hrp = getHRP()
    if not hrp then return nil end

    local closeEnemy = getEnemyInRange(150)
    if closeEnemy then
        return closeEnemy
    else
        local farEnemy = getEnemyInRange(700)
        if farEnemy then
            local dist = (farEnemy.Position - hrp.Position).Magnitude
            local time = dist / 500
            local targetPos = farEnemy.Position + Vector3.new(0,20,0)
            local tween = TweenService:Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos)})
            tween:Play()
            tween.Completed:Wait()
            return farEnemy
        end
    end
    return nil
end

function startAutoFarm()
    task.spawn(function()
        while _G.AutoFarmEnabled do
            local enemy = getEnemyInRange(300)
            if enemy then mouse1click() end
            task.wait(0.01)
        end
    end)

    task.spawn(function()
        while _G.AutoFarmEnabled do
            local hrp = getHRP()
            if hrp then
                local enemy = scanAndMove()
                if enemy then
                    local bv = hrp:FindFirstChild("FarmFloatBV") or Instance.new("BodyVelocity", hrp)
                    bv.Name = "FarmFloatBV"
                    bv.MaxForce = Vector3.new(1e5,1e5,1e5)
                    bv.Velocity = Vector3.new(0,0,0)

                    while _G.AutoFarmEnabled and isEnemyAlive(enemy) do
                        registerHitNPC(enemy)
                        attackAllPlayers()
                        mouse1click()
                        task.wait(0.035)
                        gatherEnemiesInstant(300)
                    end
                end
            end
            task.wait(0.2)
        end
    end)

    task.spawn(function()
        while _G.AutoFarmEnabled do
            gatherEnemiesInstant(300)
            task.wait(0.15)
        end
    end)
end

-- Tab 3: Các chức năng bổ sung (PvP, Rejoin, Freeze, Chặn rung)
do
    local order = 1
    local player = game.Players.LocalPlayer
    local cam = workspace.CurrentCamera

    local pvpBtn = createButton(tabFrames[3], "⚔️ PvP (Teleport gần nhất)", order); order = order + 1
    pvpBtn.MouseButton1Click:Connect(function()
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local closest, dist = nil, math.huge
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local d = (plr.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = plr
                end
            end
        end
        if closest and closest.Character and closest.Character:FindFirstChild("HumanoidRootPart") then
            hrp.CFrame = closest.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
        end
    end)

    local rejoinBtn = createButton(tabFrames[3], "🔄 Vào lại server cũ", order); order = order + 1
    rejoinBtn.MouseButton1Click:Connect(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
    end)

    local freezeBtn = createButton(tabFrames[3], "❄️ Freeze NPC OFF", order); order = order + 1
    local freezeOn = false
    freezeBtn.MouseButton1Click:Connect(function()
        freezeOn = not freezeOn
        freezeBtn.Text = freezeOn and "❄️ Freeze NPC ON" or "❄️ Freeze NPC OFF"
        if freezeOn then
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
                    if obj ~= player.Character then
                        local hum = obj.Humanoid
                        local npcHRP = obj.HumanoidRootPart
                        local dist = (npcHRP.Position - hrp.Position).Magnitude
                        if dist <= 300 then
                            hum.WalkSpeed = 0
                            hum.JumpPower = 0
                            npcHRP.Velocity = Vector3.zero
                            npcHRP.RotVelocity = Vector3.zero
                        end
                    end
                end
            end
        end
    end)

    local blockBtn = createButton(tabFrames[3], "📷 Chặn rung OFF", order); order = order + 1
    local blockShake = false
    local function enableBlock()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            cam.CameraSubject = player.Character.Humanoid
            cam.CameraType = Enum.CameraType.Custom
        end
        cam:GetPropertyChangedSignal("CameraType"):Connect(function()
            if blockShake and cam.CameraType ~= Enum.CameraType.Custom then
                cam.CameraType = Enum.CameraType.Custom
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    cam.CameraSubject = player.Character.Humanoid
                end
            end
        end)
    end

    blockBtn.MouseButton1Click:Connect(function()
        blockShake = not blockShake
        blockBtn.Text = blockShake and "📷 Chặn rung ON" or "📷 Chặn rung OFF"
        if blockShake then
            enableBlock()
        end
    end)

    player.CharacterAdded:Connect(function()
        if blockShake then
            enableBlock()
        end
    end)
end

-- Initialize canvas size for initial tab (deferred so layouts compute)
task.defer(function()
    task.wait(0.03)
    local initLayout = tabFrames[currentTab]:FindFirstChildOfClass("UIListLayout")
    if initLayout then
        mainFrame.CanvasSize = UDim2.new(0, 0, 0, initLayout.AbsoluteContentSize.Y + 40)
    end
end)
