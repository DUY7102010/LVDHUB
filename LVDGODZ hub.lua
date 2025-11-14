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

-- 🖥 GUI chính
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

-- 🔄 Toggle hiển thị
local isMinimized = false
toggleButton.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	mainFrame.Visible = not isMinimized
end)

-- 🗂 Tabs
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

-- 📱 Vuốt chuyển tab
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

-- 🍒 ESP trái cây
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
	label.Text = "🍒 " .. obj.Name
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

-- 🧍 ESP người chơi
function createPlayerESP(player)
	if player == LocalPlayer then return end
	local character = player.Character
	if not character or not character:FindFirstChild("Head") then return end
	local head = character.Head
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or head:FindFirstChild("PlayerESP") then return end

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

-- Khởi tạo ESP người chơi
for _, player in pairs(Players:GetPlayers()) do
	createPlayerESP(player)
	player.CharacterAdded:Connect(function()
		wait(1)
		createPlayerESP(player)
	end)
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		wait(1)
		createPlayerESP(player)
	end)
end)

for _, obj in pairs(workspace:GetChildren()) do
	createFruitESP(obj)
end

workspace.ChildAdded:Connect(function(obj)
	task.wait(0.5)
	createFruitESP(obj)
end)

-- 🎯 GUI nhỏ điều khiển Aimbot
local aimbotEnabled = false
local aimbotGui = nil

local function createAimbotGui()
	if aimbotGui then return end

	aimbotGui = Instance.new("ScreenGui", PlayerGui)
	aimbotGui.Name = "AimbotControl"

	local frame = Instance.new("Frame", aimbotGui)
	frame.Size = UDim2.new(0, 200, 0, 100)
	frame.Position = UDim2.new(1, -220, 1, -120)
	frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	frame.BorderSizePixel = 2
	frame.BorderColor3 = Color3.fromRGB(255, 85, 0)
	Instance.new("UICorner", frame)

	local toggleBtn = Instance.new("TextButton", frame)
	toggleBtn.Size = UDim2.new(1, -20, 0.5, -10)
	toggleBtn.Position = UDim2.new(0, 10, 0, 10)
	toggleBtn.Text = "🎯 Bật Aimbot"
	toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	toggleBtn.TextColor3 = Color3.new(1, 1, 1)
	Instance.new("UICorner", toggleBtn)

	local closeBtn = Instance.new("TextButton", frame)
	closeBtn.Size = UDim2.new(1, -20, 0.5, -10)
	closeBtn.Position = UDim2.new(0, 10, 0.5, 10)
	closeBtn.Text = "❌ Đóng"
	closeBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
	closeBtn.TextColor3 = Color3.new(1, 1, 1)
	Instance.new("UICorner", closeBtn)

	toggleBtn.MouseButton1Click:Connect(function()
		aimbotEnabled = not aimbotEnabled
		toggleBtn.Text = aimbotEnabled and "✅ Đang Aimbot" or "🎯 Bật Aimbot"
	end)

	closeBtn.MouseButton1Click:Connect(function()
		aimbotGui:Destroy()
		aimbotGui = nil
		aimbotEnabled = false
	end)
end

-- 🧠 Logic Aimbot
RunService.RenderStepped:Connect(function()
	if not aimbotEnabled then return end
	local closestTarget = nil
	local shortestDistance = math.huge
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local targetHRP = player.Character.HumanoidRootPart
			local screenPos, onScreen = Camera:WorldToViewportPoint(targetHRP.Position)
			if onScreen then
				local distance = (Vector2.new(screenPos.X, screenPos.Y) - UserInputService:GetMouseLocation()).Magnitude
				if distance < shortestDistance then
					shortestDistance = distance
					closestTarget = targetHRP
				end
			end
		end
	end

	if closestTarget then
		Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestTarget.Position)
	end
end)

-- 📦 Gắn nút mở GUI Aimbot vào Tab 3
local aimbotBtn = Instance.new("TextButton", tabFrames[3])
aimbotBtn.Size = UDim2.new(0, 200, 0, 40)
aimbotBtn.Position = UDim2.new(0, 20, 0, 20)
aimbotBtn.Text = "🎯 Mở GUI Aimbot"
aimbotBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
aimbotBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", aimbotBtn)

aimbotBtn.MouseButton1Click:Connect(function()
	createAimbotGui()
end)
