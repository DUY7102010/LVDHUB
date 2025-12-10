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
    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
    label.Text = plr.Name .. " (" .. math.floor(dist) .. "m) HP:" .. math.floor(hum.Health)
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
mainFrame.CanvasSize = UDim2.new(0,0,0,600)
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

    tabLabel.MouseButton1Click:Connect(function()
        currentTab = i
        for j, frame in ipairs(tabFrames) do
                    frame.Visible = (j == i)
        tabBar["Tab"..j].BackgroundColor3 = (j==i) and Color3.fromRGB(100,100,100) or Color3.fromRGB(200,200,200)
        tabBar["Tab"..j].TextColor3 = (j==i) and Color3.fromRGB(255,255,255) or Color3.fromRGB(0,0,0)
        tabBar["Tab"..j]:FindFirstChildOfClass("Frame").Visible = (j==i)
    end
end)
end

-- TAB 1: San Sea + Fly/Noclip/Speed + ESP Player
do
    -- San Sea
    local sanSeaBtn = Instance.new("TextButton", tabFrames[1])
    sanSeaBtn.Size = UDim2.new(0, 200, 0, 40)
    sanSeaBtn.Position = UDim2.new(0, 20, 0, 20)
    sanSeaBtn.Text = "⚙️ Bật script San Sea"
    sanSeaBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    sanSeaBtn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", sanSeaBtn)
    sanSeaBtn.MouseButton1Click:Connect(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DUY7102010/san-sea/refs/heads/main/san-sea.lua"))()
        end)
        if not ok then warn("Không tải được San Sea: " .. tostring(err)) end
    end)

    -- ✈️ Fly với nút tăng/giảm tốc độ
local flying = false
local flySpeed = 50
local flyBtn = Instance.new("TextButton", tabFrames[1])
flyBtn.Size = UDim2.new(0,200,0,40)
flyBtn.Position = UDim2.new(0,20,0,70)
flyBtn.Text = "✈️ Fly"
flyBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
flyBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", flyBtn)

local minusBtn, speedLabel, plusBtn
flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        flyBtn.Text = "✈️ Fly (ON)"
        local hrp = safeGetCharacterHumanoidRootPart()
        -- tạo BodyVelocity riêng
        local bv = Instance.new("BodyVelocity")
        bv.Name = "LVDGODZ_FlyBV"
        bv.MaxForce = Vector3.new(1e5,1e5,1e5)
        bv.Parent = hrp

        -- loop bay
        RunService.RenderStepped:Connect(function()
            if flying and hrp and hrp:FindFirstChild("LVDGODZ_FlyBV") then
                local move = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += Camera.CFrame.RightVector end
                hrp.LVDGODZ_FlyBV.Velocity = move.Magnitude>0 and move.Unit*flySpeed or Vector3.zero
            end
        end)

        -- tạo nút chỉnh tốc độ
        minusBtn = Instance.new("TextButton", tabFrames[1])
        minusBtn.Size = UDim2.new(0,40,0,40)
        minusBtn.Position = UDim2.new(0,230,0,70)
        minusBtn.Text = "-"
        speedLabel = Instance.new("TextLabel", tabFrames[1])
        speedLabel.Size = UDim2.new(0,40,0,40)
        speedLabel.Position = UDim2.new(0,270,0,70)
        speedLabel.Text = tostring(flySpeed)
        plusBtn = Instance.new("TextButton", tabFrames[1])
        plusBtn.Size = UDim2.new(0,40,0,40)
        plusBtn.Position = UDim2.new(0,310,0,70)
        plusBtn.Text = "+"

        minusBtn.MouseButton1Click:Connect(function()
            flySpeed = math.max(10, flySpeed-10)
            speedLabel.Text = tostring(flySpeed)
        end)
        plusBtn.MouseButton1Click:Connect(function()
            flySpeed = flySpeed+10
            speedLabel.Text = tostring(flySpeed)
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
        if minusBtn then minusBtn:Destroy() end
        if plusBtn then plusBtn:Destroy() end
        if speedLabel then speedLabel:Destroy() end
    end
end)

    -- 🚪 Noclip
    local noclip = false
    local noclipBtn = Instance.new("TextButton", tabFrames[1])
    noclipBtn.Size = UDim2.new(0,200,0,40)
    noclipBtn.Position = UDim2.new(0,20,0,120)
    noclipBtn.Text = "🚪 Noclip"
    noclipBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    noclipBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", noclipBtn)
    noclipBtn.MouseButton1Click:Connect(function()
        noclip = not noclip
    end)
    RunService.Stepped:Connect(function()
        if noclip and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)

    -- 🏃 Speed slider (bật/tắt)
local speedOn = false
local currentSpeed = 16
local speedBtn = Instance.new("TextButton", tabFrames[1])
speedBtn.Size = UDim2.new(0,200,0,40)
speedBtn.Position = UDim2.new(0,20,0,170)
speedBtn.Text = "🏃 Speed"
speedBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
speedBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", speedBtn)

local sliderFrame, sliderBar, sliderHandle
speedBtn.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    if speedOn then
        speedBtn.Text = "🏃 Speed (ON)"
        sliderFrame = Instance.new("Frame", tabFrames[1])
        sliderFrame.Size = UDim2.new(0,200,0,20)
        sliderFrame.Position = UDim2.new(0,20,0,210)
        sliderBar = Instance.new("Frame", sliderFrame)
        sliderBar.Size = UDim2.new(1,0,1,0)
        sliderBar.BackgroundColor3 = Color3.fromRGB(100,100,100)
        sliderHandle = Instance.new("Frame", sliderFrame)
        sliderHandle.Size = UDim2.new(0,10,1,0)
        sliderHandle.BackgroundColor3 = Color3.fromRGB(255,0,0)

        local dragging=false
        sliderHandle.InputBegan:Connect(function(input)
            if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end
        end)
        sliderHandle.InputEnded:Connect(function(input)
            if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end
        end)

        RunService.RenderStepped:Connect(function()
            if speedOn and sliderFrame and sliderHandle and dragging then
                local mouseX = UserInputService:GetMouseLocation().X
                local rel = math.clamp((mouseX-sliderFrame.AbsolutePosition.X)/sliderFrame.AbsoluteSize.X,0,1)
                sliderHandle.Position = UDim2.new(rel, -5, 0, 0)
                currentSpeed = math.floor(16+rel*(400-16))
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid.WalkSpeed = currentSpeed
                end
                speedBtn.Text = "🏃 Speed: "..currentSpeed
            end
        end)
    else
        speedBtn.Text = "🏃 Speed"
        if sliderFrame then sliderFrame:Destroy() end
        -- reset về mặc định khi tắt
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
        currentSpeed = 16
    end
end)

    -- 👤 ESP Player
    local espPlayerBtn = Instance.new("TextButton", tabFrames[1])
    espPlayerBtn.Size = UDim2.new(0,200,0,40)
    espPlayerBtn.Position = UDim2.new(0,20,0,240)
    espPlayerBtn.Text = "👤 Bật ESP Player"
    espPlayerBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    espPlayerBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", espPlayerBtn)
    espPlayerBtn.MouseButton1Click:Connect(function()
        for _, plr in pairs(Players:GetPlayers()) do
            createPlayerESP(plr)
        end
    end)
end


-- TAB 2: Nhặt trái & ESP trái cây
do
    -- 🍒 Nhặt trái cây (tele tất cả trái về nhân vật)
do
    local collectBtn = Instance.new("TextButton", tabFrames[2])
    collectBtn.Size = UDim2.new(0,200,0,40)
    collectBtn.Position = UDim2.new(0,20,0,20)
    collectBtn.Text = "🍒 Nhặt trái cây"
    collectBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    collectBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", collectBtn)

    collectBtn.MouseButton1Click:Connect(function()
        local hrp = safeGetCharacterHumanoidRootPart()
        if not hrp then return end
        for _, obj in pairs(workspace:GetDescendants()) do
            -- chỉ tele Tool có Handle (trái cây)
            if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                -- tele trái về ngay nhân vật để kẹt vào người và tự động nhặt
                obj.Handle.CFrame = hrp.CFrame
            end
        end
    end)
end

    -- 👁️ ESP trái cây (chỉ hiển thị)
    local espBtn = Instance.new("TextButton", tabFrames[2])
    espBtn.Size = UDim2.new(0,200,0,40)
    espBtn.Position = UDim2.new(0,20,0,70)
    espBtn.Text = "👁️ Bật ESP trái cây"
    espBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    espBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", espBtn)

    espBtn.MouseButton1Click:Connect(function()
        for _, obj in pairs(workspace:GetChildren()) do
            createFruitESP(obj)
        end
    end)

    -- tự động gắn ESP cho trái mới spawn
    workspace.DescendantAdded:Connect(function(obj)
        createFruitESP(obj)
    end)
end

-- TAB 3: Hop Server + Platform xanh dương + Xoá rung màn hình
do
    -- Hop Server (giữ nguyên như trước)
    local hopBtn = Instance.new("TextButton", tabFrames[3])
    hopBtn.Size = UDim2.new(0,200,0,40)
    hopBtn.Position = UDim2.new(0,20,0,20)
    hopBtn.Text = "🔁 Hop Server"
    hopBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    hopBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", hopBtn)

    local PlaceId = game.PlaceId
    local CurrentJobId = game.JobId
    local function hopServer()
        local success, result = pcall(function()
            local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
            return HttpService:JSONDecode(game:HttpGet(url))
        end)
        if success and result and result.data then
            local lowestCount = math.huge
            local bestServerId = nil
            for _, server in pairs(result.data) do
                if server.id ~= CurrentJobId and server.playing < server.maxPlayers then
                    if server.playing < lowestCount then
                        lowestCount = server.playing
                        bestServerId = server.id
                    end
                end
            end
            if bestServerId then
                TeleportService:TeleportToPlaceInstance(PlaceId, bestServerId, LocalPlayer)
            end
        end
    end
    hopBtn.MouseButton1Click:Connect(hopServer)

    -- 🟦 Platform xanh dương
    local function spawnPlatform()
        local hrp = safeGetCharacterHumanoidRootPart()
        if not hrp then return end
        local part = Instance.new("Part")
        part.Size = Vector3.new(3,0.5,3)
        part.Position = hrp.Position - Vector3.new(0,3,0)
        part.Anchored = true
        part.CanCollide = true
        part.Transparency = 0.5
        part.Color = Color3.fromRGB(0,0,255)
        part.Parent = workspace
        game:GetService("Debris"):AddItem(part,2)
        task.delay(1.75,function()
            spawnPlatform()
        end)
    end

    local platformBtn = Instance.new("TextButton", tabFrames[3])
    platformBtn.Size = UDim2.new(0,200,0,40)
    platformBtn.Position = UDim2.new(0,20,0,70)
    platformBtn.Text = "🟦 Spawn Platform"
    platformBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    platformBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", platformBtn)
    platformBtn.MouseButton1Click:Connect(spawnPlatform)

    -- ❌ Xoá hiệu ứng rung màn hình
    local clearShakeBtn = Instance.new("TextButton", tabFrames[3])
    clearShakeBtn.Size = UDim2.new(0,200,0,40)
    clearShakeBtn.Position = UDim2.new(0,20,0,120)
    clearShakeBtn.Text = "❌ Xoá rung màn hình"
    clearShakeBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    clearShakeBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", clearShakeBtn)

    clearShakeBtn.MouseButton1Click:Connect(function()
        -- reset Camera về mặc định
        Camera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        Camera.CameraType = Enum.CameraType.Custom
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Camera.CFrame.LookVector)

        -- xoá các hiệu ứng rung nếu có gắn vào Camera
        for _, v in pairs(Camera:GetChildren()) do
            if v:IsA("Tween") or v:IsA("BodyPosition") or v:IsA("BodyVelocity") then
                v:Destroy()
            end
        end
    end)
end

-- ⚔️ PvP (Tab 3)
do
    local pvpFrame = tabFrames[3]

    local pvpLabel = Instance.new("TextLabel", pvpFrame)
    pvpLabel.Size = UDim2.new(0,200,0,40)
    pvpLabel.Position = UDim2.new(0,20,0,20)
    pvpLabel.Text = "⚔️ PvP"
    pvpLabel.BackgroundColor3 = Color3.fromRGB(60,60,60)
    pvpLabel.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", pvpLabel)

    local uis = game:GetService("UserInputService")
    local rs = game:GetService("RunService")
    local player = game.Players.LocalPlayer

    -- setup nhân vật: double jump
    local function setupCharacter(character)
        local humanoid = character:WaitForChild("Humanoid")

        humanoid.JumpPower = 50
        local clicked, clickTime = false, 0
        local window = 0.25

        -- click chuột trái
        uis.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                clicked = true
                clickTime = tick()
            end
        end)

        -- nhấn Space
        uis.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.KeyCode == Enum.KeyCode.Space then
                if clicked and tick() - clickTime <= window then
                    humanoid.JumpPower = 400
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    task.delay(0.25, function()
                        if humanoid and humanoid.Parent then
                            humanoid.JumpPower = 50
                        end
                    end)
                    clicked = false
                else
                    humanoid.Jump = true
                end
            end
        end)

        -- reset click nếu quá thời gian
        rs.Heartbeat:Connect(function()
            if clicked and tick() - clickTime > window then
                clicked = false
            end
        end)
    end

    -- teleport tới người chơi gần nhất
    local function teleportToClosest()
        local character = player.Character
        if not character then return end
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local closestHRP, closestDistance = nil, math.huge
        for _, other in ipairs(game.Players:GetPlayers()) do
            if other ~= player and other.Character then
                local otherHRP = other.Character:FindFirstChild("HumanoidRootPart")
                if otherHRP then
                    local distance = (hrp.Position - otherHRP.Position).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestHRP = otherHRP
                    end
                end
            end
        end

        if closestHRP then
            hrp.CFrame = closestHRP.CFrame * CFrame.new(0, 3, 0)
        end
    end

    -- phím G: teleport tới người chơi gần nhất
    uis.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.G then
            teleportToClosest()
        end
    end)

    -- setup khi nhân vật spawn
    if player.Character then
        setupCharacter(player.Character)
    end
    player.CharacterAdded:Connect(setupCharacter)
end

-- 🔄 Vào lại server cũ (Tab 3)
do
    local rejoinBtn = Instance.new("TextButton", tabFrames[3])
    rejoinBtn.Size = UDim2.new(0,200,0,40)
    rejoinBtn.Position = UDim2.new(0,20,0,20)
    rejoinBtn.Text = "🔄 Vào lại server cũ"
    rejoinBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    rejoinBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", rejoinBtn)

    local TeleportService = game:GetService("TeleportService")
    local player = game.Players.LocalPlayer

    rejoinBtn.MouseButton1Click:Connect(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
    end)
end

-- 🔄 Vào lại server cũ (Tab 3)
do
    local rejoinBtn = Instance.new("TextButton", tabFrames[3])
    rejoinBtn.Size = UDim2.new(0,200,0,40)
    rejoinBtn.Position = UDim2.new(0,20,0,20)
    rejoinBtn.Text = "🔄 Vào lại server cũ"
    rejoinBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    rejoinBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", rejoinBtn)

    local TeleportService = game:GetService("TeleportService")
    local player = game.Players.LocalPlayer

    rejoinBtn.MouseButton1Click:Connect(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
    end)
end

-- ❄️ Freeze NPC (Tab 3)
do
    local freezeOn = false

    local freezeBtn = Instance.new("TextButton", tabFrames[3])
    freezeBtn.Size = UDim2.new(0,200,0,40)
    freezeBtn.Position = UDim2.new(0,20,0,70)
    freezeBtn.Text = "❄️ Freeze NPC OFF"
    freezeBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    freezeBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", freezeBtn)

    local player = game.Players.LocalPlayer

    local function freezeNPCsOnce()
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

    freezeBtn.MouseButton1Click:Connect(function()
        freezeOn = not freezeOn
        freezeBtn.Text = freezeOn and "❄️ Freeze NPC ON" or "❄️ Freeze NPC OFF"
        if freezeOn then
            freezeNPCsOnce()
        end
    end)
end

-- 📷 Chặn rung màn hình (Tab 3)
do
    local blockShake = false

    local blockBtn = Instance.new("TextButton", tabFrames[3])
    blockBtn.Size = UDim2.new(0,200,0,40)
    blockBtn.Position = UDim2.new(0,20,0,70)
    blockBtn.Text = "📷 Chặn rung OFF"
    blockBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    blockBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", blockBtn)

    local player = game.Players.LocalPlayer
    local cam = workspace.CurrentCamera

    local function enableBlock()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            cam.CameraSubject = player.Character.Humanoid
            cam.CameraType = Enum.CameraType.Custom
        end
        -- chỉ chặn khi có script cố đổi CameraType
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
