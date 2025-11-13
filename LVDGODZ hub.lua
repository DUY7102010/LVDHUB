-- ⚙️ Dịch vụ
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

-- 📦 GUI chính
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "LVDGODZ_GUI"
gui.ResetOnSpawn = false

-- 🌑 Nút thu nhỏ
local toggleButton = Instance.new("TextButton", gui)
toggleButton.Size = UDim2.new(0, 100, 0, 40)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleButton.Text = "LVDGODZ"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 18
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", toggleButton)

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

-- Biến kiểm tra trạng thái thu nhỏ
local isMinimized = false

-- Cho phép kéo nút thu nhỏ
toggleButton.Active = true
toggleButton.Draggable = true

-- Khi nhấn nút, ẩn hoặc hiện GUI chính
toggleButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    mainFrame.Visible = not isMinimized
end)

-- 🖼️ Main Frame
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

-- Viền trắng trong
local innerBorder = Instance.new("Frame", mainFrame)
innerBorder.Size = UDim2.new(1, 10, 1, 10)
innerBorder.Position = UDim2.new(0, -5, 0, -5)
innerBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
innerBorder.BorderSizePixel = 0
innerBorder.ZIndex = mainFrame.ZIndex - 1
Instance.new("UICorner", innerBorder)

-- Viền xanh dương ngoài cùng
local outerBorder = Instance.new("Frame", gui)
outerBorder.Size = UDim2.new(0, 520, 0, 320)
outerBorder.Position = UDim2.new(0.5, -260, 0.5, -160)
outerBorder.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
outerBorder.BorderSizePixel = 0
outerBorder.ZIndex = mainFrame.ZIndex - 2
Instance.new("UICorner", outerBorder)

-- Thanh tab số 1 2 3
local tabBar = Instance.new("Frame", mainFrame)
tabBar.Size = UDim2.new(1, 0, 0, 20)
tabBar.Position = UDim2.new(0, 0, 0, -20)
tabBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tabBar.BorderSizePixel = 0

for i = 1, 3 do
    local tabLabel = Instance.new("TextLabel", tabBar)
    tabLabel.Size = UDim2.new(1/3, 0, 1, 0)
    tabLabel.Position = UDim2.new((i-1)/3, 0, 0, 0)
    tabLabel.Text = tostring(i)
    tabLabel.Font = Enum.Font.GothamBold
    tabLabel.TextSize = 14
    tabLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    tabLabel.BackgroundTransparency = 1
end

-- Kéo GUI khi nhấn vào viền trắng trong
local draggingGui = false
local dragOffset = Vector2.new()

innerBorder.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingGui = true
        dragOffset = input.Position - mainFrame.Position
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingGui = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingGui and input.UserInputType == Enum.UserInputType.MouseMovement then
        mainFrame.Position = UDim2.new(0, input.Position.X - dragOffset.X, 0, input.Position.Y - dragOffset.Y)
        outerBorder.Position = mainFrame.Position - UDim2.new(0, 10, 0, 10)
    end
end)

-- ❌ Nút X
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
Instance.new("UICorner", closeBtn)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- 🖋️ Chữ ký
local signature = Instance.new("TextLabel", mainFrame)
signature.Size = UDim2.new(0, 120, 0, 20)
signature.Position = UDim2.new(0, 10, 0, 5)
signature.BackgroundTransparency = 1
signature.Text = "LVDGODZ"
signature.Font = Enum.Font.GothamSemibold
signature.TextSize = 14
signature.TextColor3 = Color3.fromRGB(200, 200, 200)
signature.TextTransparency = 0.2

-- Thanh tab số
local tabBar = Instance.new("Frame", mainFrame)
tabBar.Size = UDim2.new(1, 0, 0, 20)
tabBar.Position = UDim2.new(0, 0, 0, -20)
tabBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tabBar.BorderSizePixel = 0

for i = 1, 3 do
    local tabLabel = Instance.new("TextLabel", tabBar)
    tabLabel.Size = UDim2.new(1/3, 0, 1, 0)
    tabLabel.Position = UDim2.new((i-1)/3, 0, 0, 0)
    tabLabel.Text = tostring(i)
    tabLabel.Font = Enum.Font.GothamBold
    tabLabel.TextSize = 14
    tabLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    tabLabel.BackgroundTransparency = 1
end

-- 📄 Tabs
local tabHolder = Instance.new("Frame", mainFrame)
tabHolder.Size = UDim2.new(3, 0, 1, 0)
tabHolder.Position = UDim2.new(0, 0, 0, 0)
tabHolder.BackgroundTransparency = 1
tabHolder.ClipsDescendants = true

local tabs = {}
local tabNames = {"Home", "Fruit", "Tools"}
for i = 1, 3 do
	local tab = Instance.new("Frame", tabHolder)
	tab.Size = UDim2.new(1/3, 0, 1, 0)
	tab.Position = UDim2.new((i-1)/3, 0, 0, 0)
	tab.BackgroundTransparency = 1

	local label = Instance.new("TextLabel", tab)
	label.Size = UDim2.new(1, 0, 0, 40)
	label.Position = UDim2.new(0, 0, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = tabNames[i]
	label.Font = Enum.Font.GothamBold
	label.TextSize = 24
	label.TextColor3 = Color3.new(1, 1, 1)

	tabs[i] = tab
end

-- Lưu tab hiện tại và danh sách tab
local currentTab = 1
local tabs = {tab1, tab2, tab3}

-- Hàm chuyển tab
local function switchTab(index)
    for i, tab in ipairs(tabs) do
        tab.Visible = (i == index)
    end
    currentTab = index
end

-- Gắn sự kiện nhấn vào số tab
for i = 1, 3 do
    local tabLabel = tabBar:FindFirstChild(tostring(i))
    if tabLabel then
        tabLabel.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                switchTab(i)
            end
        end)
    end
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
            if deltaX < 0 and currentTab < #tabs then
                switchTab(currentTab + 1)
            elseif deltaX > 0 and currentTab > 1 then
                switchTab(currentTab - 1)
            end
        end
        swipeStartX = nil
    end
end)

-- 🧱 Hàm tạo nút
local function createButton(parent, text, yPos, callback)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(0, 140, 0, 40)
	btn.Position = UDim2.new(0.1, 0, yPos, 0)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 20
	Instance.new("UICorner", btn)
	btn.MouseButton1Click:Connect(callback)
end

-- 🍒 ESP trái cây
local fruitColors = {
	["Dragon Fruit"] = Color3.fromRGB(255,0,0),
	["Leopard Fruit"] = Color3.fromRGB(255,85,0),
	["Dough Fruit"] = Color3.fromRGB(255,170,0),
	["Light Fruit"] = Color3.fromRGB(255,255,0),
	["Flame Fruit"] = Color3.fromRGB(255,100,0),
	["Bomb Fruit"] = Color3.fromRGB(200,200,200),
}

local function createESP(obj)
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

-- 🧠 ESP người chơi
local function createPlayerESP(player)
	if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
	local hrp = player.Character.HumanoidRootPart
	local gui = Instance.new("BillboardGui", hrp)
	gui.Name = "PlayerESP"
	gui.Size = UDim2.new(0, 100, 0, 40)
	gui.AlwaysOnTop = true
	gui.StudsOffset = Vector3.new(0, 2, 0)
	gui.Adornee = hrp
	local label = Instance.new("TextLabel", gui)
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.TextScaled = true
	label.TextStrokeTransparency = 0
	label.Font = Enum.Font.GothamBold
	local teamColor = player.Team == LocalPlayer.Team and Color3.fromRGB(85, 255, 170) or Color3.fromRGB(255, 85, 85)
	label.TextColor3 = teamColor
	RunService.RenderStepped:Connect(function()
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
			local dist = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
			local hp = player.Character.Humanoid.Health
			label.Text = string.format("👤 %s\n❤️ %.0f HP\n📏 %.0f m", player.Name, hp, dist)
		else
			gui:Destroy()
		end
	end)
end

for _, plr in pairs(Players:GetPlayers()) do
	if plr ~= LocalPlayer then createPlayerESP(plr) end
end
Players.PlayerAdded:Connect(function(plr)
	if plr ~= LocalPlayer then
		plr.CharacterAdded:Connect(function()
			task.wait(1)
			createPlayerESP(plr)
		end)
	end
end)

-- ✈️ Bay đến trái
local function bayDen(trai)
	local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local hrp = character:WaitForChild("HumanoidRootPart", 5)
	if trai and trai:FindFirstChild("Handle") and hrp then
		local targetPos = trai.Handle.Position + Vector3.new(0,5,0)
		local distance = (hrp.Position - targetPos).Magnitude
		local duration = distance / Speed
		local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
		local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(targetPos)})
		tween:Play()
	end
end

-- 🔁 Hop Server
local function hopServer()
	local success, result = pcall(function()
		return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
	end)
	if success and result and result.data then
		for _, server in pairs(result.data) do
			if server.playing < server.maxPlayers and server.id ~= game.JobId then
				TeleportService:TeleportToPlaceInstance(PlaceId, server.id, LocalPlayer)
				return
			end
		end
	end
end

-- 🧩 Tab 2: Nhặt trái + ESP trái
createButton(tabs[2], "Bật Nhặt Trái", 0.3, function()
	task.spawn(function()
		while true do
			local coTrai = false
			for _, obj in pairs(workspace:GetChildren()) do
				if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
					coTrai = true
					createESP(obj)
					if not daXuLy[obj] then
						daXuLy[obj] = true
						bayDen(obj)
						repeat task.wait(1) until not obj.Parent or obj.Parent == LocalPlayer.Backpack
						task.wait(10)
						hopServer()
					end
				end
			end
			if not coTrai then hopServer() end
			task.wait(ScanInterval)
		end
	end)
end)

createButton(tabs[2], "Bật ESP Trái", 0.55, function()
	for _, v in pairs(workspace:GetChildren()) do
		if v:IsA("Tool") and v:FindFirstChild("Handle") then
			createESP(v)
		end
	end
end)

-- 🧩 Tab 3: Hop Server VIP + PVP + Aimbot GUI
createButton(tabs[3], "Hop Server VIP", 0.3, hopServer)
createButton(tabs[3], "PVP Mode", 0.55, function()
	print("PVP Mode triggered!") -- thêm chức năng thật nếu cần
end)

createButton(tabs[3], "Aimbot GUI", 0.8, function()
	if not LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("AimbotToggle") then
		local aimbotGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
		aimbotGui.Name = "AimbotToggle"
		local frame = Instance.new("Frame", aimbotGui)
		frame.Size = UDim2.new(0, 120, 0, 50)
		frame.Position = UDim2.new(0, 200, 0, 100)
		frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		frame.BackgroundTransparency = 0.2
		frame.Active = true
		frame.Draggable = true
		Instance.new("UICorner", frame)
		local btn = Instance.new("TextButton", frame)
		btn.Size = UDim2.new(1, 0, 1, 0)
		btn.Text = "Aimbot: OFF"
		btn.Font = Enum.Font.GothamBold
		btn.TextSize = 18
		btn.TextColor3 = Color3.new(1, 1, 1)
		btn.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
		Instance.new("UICorner", btn)
		local aimbotOn = false
		btn.MouseButton1Click:Connect(function()
			aimbotOn = not aimbotOn
			btn.Text = "Aimbot: " .. (aimbotOn and "ON" or "OFF")
		end)
		RunService.RenderStepped:Connect(function()
			if aimbotOn then
				local closest, shortest = nil, math.huge
				for _, plr in pairs(Players:GetPlayers()) do
					if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
						local dist = (plr.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
						if dist < shortest then
							closest = plr.Character.HumanoidRootPart
							shortest = dist
						end
					end
				end
				if closest then
					workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closest.Position)
				end
			end
		end)
	end
end)
