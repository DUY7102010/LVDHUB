-- Các dịch vụ cần thiết
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Tạo GUI
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
toggleButton.Active = true
toggleButton.Draggable = true
Instance.new("UICorner", toggleButton)

-- Hiệu ứng màu chữ
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

-- GUI chính
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = false
Instance.new("UICorner", mainFrame)

-- Viền trắng trong
local innerBorder = Instance.new("Frame", mainFrame)
innerBorder.Size = UDim2.new(1, 10, 1, 10)
innerBorder.Position = UDim2.new(0, -5, 0, -5)
innerBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
innerBorder.BorderSizePixel = 0
innerBorder.ZIndex = 1
Instance.new("UICorner", innerBorder)

-- Viền xanh dương ngoài cùng
local outerBorder = Instance.new("Frame", gui)
outerBorder.Size = UDim2.new(0, 520, 0, 320)
outerBorder.Position = UDim2.new(0.5, -260, 0.5, -160)
outerBorder.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
outerBorder.BorderSizePixel = 0
outerBorder.ZIndex = 0
Instance.new("UICorner", outerBorder)

-- Kéo GUI khi nhấn vào viền trắng
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

-- Toggle hiển thị GUI
local isMinimized = false
toggleButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    mainFrame.Visible = not isMinimized
end)

-- Thanh tab 1 2 3
local tabBar = Instance.new("Frame", mainFrame)
tabBar.Size = UDim2.new(1, 0, 0, 20)
tabBar.Position = UDim2.new(0, 0, 0, -20)
tabBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tabBar.BorderSizePixel = 0

for i = 1, 3 do
    local tabLabel = Instance.new("TextLabel", tabBar)
    tabLabel.Name = tostring(i)
    tabLabel.Size = UDim2.new(1/3, 0, 1, 0)
    tabLabel.Position = UDim2.new((i-1)/3, 0, 0, 0)
    tabLabel.Text = tostring(i)
    tabLabel.Font = Enum.Font.GothamBold
    tabLabel.TextSize = 14
    tabLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    tabLabel.BackgroundTransparency = 1
end

-- Tạo tab nội dung
local tab1 = Instance.new("Frame", mainFrame)
tab1.Size = UDim2.new(1, 0, 1, 0)
tab1.Position = UDim2.new(0, 0, 0, 0)
tab1.BackgroundTransparency = 1
tab1.Visible = true

local tab2 = Instance.new("Frame", mainFrame)
tab2.Size = UDim2.new(1, 0, 1, 0)
tab2.Position = UDim2.new(0, 0, 0, 0)
tab2.BackgroundTransparency = 1
tab2.Visible = false

local tab3 = Instance.new("Frame", mainFrame)
tab3.Size = UDim2.new(1, 0, 1, 0)
tab3.Position = UDim2.new(0, 0, 0, 0)
tab3.BackgroundTransparency = 1
tab3.Visible = false

-- Chuyển tab bằng nhấn và vuốt
local currentTab = 1
local tabFrames = {tab1, tab2, tab3}

local function switchTab(index)
    for i, tab in ipairs(tabFrames) do
        tab.Visible = (i == index)
    end
    currentTab = index
end

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
                switchTab(currentTab + 1)
            elseif deltaX > 0 and currentTab > 1 then
                switchTab(currentTab - 1)
            end
        end
        swipeStartX = nil
    end
end)
