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

local sanSeaBtn = Instance.new("TextButton", tabFrames[1])
sanSeaBtn.Size = UDim2.new(0, 200, 0, 40)
sanSeaBtn.Position = UDim2.new(0, 20, 0, 20)
sanSeaBtn.Text = "⚙️ Bật script San Sea"
sanSeaBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
sanSeaBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", sanSeaBtn)

sanSeaBtn.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/DUY7102010/san-sea/refs/heads/main/san-sea.lua"))()
end)
-- TAB 2: Nhặt trái & ESP
local collectBtn = Instance.new("TextButton", tabFrames[2])
collectBtn.Size = UDim2.new(0, 200, 0, 40)
collectBtn.Position = UDim2.new(0, 20, 0, 20)
collectBtn.Text = "🍒 Nhặt trái cây"
collectBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
collectBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", collectBtn)

collectBtn.MouseButton1Click:Connect(function()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
			obj.Handle.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
		end
	end
end)

local espBtn = Instance.new("TextButton", tabFrames[2])
espBtn.Size = UDim2.new(0, 200, 0, 40)
espBtn.Position = UDim2.new(0, 20, 0, 70)
espBtn.Text = "👁️ Bật ESP trái cây"
espBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", espBtn)

espBtn.MouseButton1Click:Connect(function()
	for _, obj in pairs(workspace:GetChildren()) do
		createFruitESP(obj)
	end
end)

-- TAB 3: Aimbot & Server VIP
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

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = game.Players.LocalPlayer

local vipBtn = Instance.new("TextButton", tabFrames[3])
vipBtn.Size = UDim2.new(0, 200, 0, 40)
vipBtn.Position = UDim2.new(0, 20, 0, 70)
vipBtn.Text = "🧭 Chuyển đến server ít người nhất"
vipBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
vipBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", vipBtn)

vipBtn.MouseButton1Click:Connect(function()
	local placeId = game.PlaceId
	local currentJobId = game.JobId
	local cursor = ""
	local lowestCount = math.huge
	local bestServerId = nil
	local fallbackServerId = nil

	print("🔍 Đang tìm server ít người nhất...")

	while true do
		local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
		if cursor ~= "" then url = url .. "&cursor=" .. cursor end

		local success, response = pcall(function()
			return game:HttpGet(url)
		end)

		if not success then
			warn("❌ Không thể lấy dữ liệu server.")
			break
		end

		local data = HttpService:JSONDecode(response)
		for _, server in pairs(data.data) do
			if server.id ~= currentJobId then
				if server.playing < lowestCount then
					lowestCount = server.playing
					bestServerId = server.id
				end
				if not fallbackServerId then
					fallbackServerId = server.id
				end
			end
		end

		if data.nextPageCursor then
			cursor = data.nextPageCursor
		else
			break
		end
	end

	if bestServerId then
		print("✅ Đang chuyển đến server có " .. lowestCount .. " người chơi.")
		TeleportService:TeleportToPlaceInstance(placeId, bestServerId, LocalPlayer)
	elseif fallbackServerId then
		print("⚠️ Không tìm được server ít nhất, đang chuyển đến server khác.")
		TeleportService:TeleportToPlaceInstance(placeId, fallbackServerId, LocalPlayer)
	else
		warn("❌ Không tìm thấy server nào khác.")
	end
end)
