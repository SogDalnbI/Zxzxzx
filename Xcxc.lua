-- Основной скрипт для создания меню и загрузки внешнего скрипта

local menu = nil
local toggleButton = nil
local buttons = {}

-- Создание основного меню
local function createMenu()
    menu = Instance.new("Frame")
    menu.Size = UDim2.new(0, 300, 0, 200)
    menu.Position = UDim2.new(0.5, -150, 0.5, -100)
    menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    menu.BackgroundTransparency = 0.3
    menu.BorderSizePixel = 0
    menu.ClipsDescendants = true
    menu.Parent = game.Players.LocalPlayer.PlayerGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 45)
    corner.Parent = menu

    -- Кнопка закрытия меню
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 50, 0, 30)
    closeButton.Position = UDim2.new(1, -60, 0, 10)
    closeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Parent = menu

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 15)
    closeCorner.Parent = closeButton

    closeButton.MouseButton1Click:Connect(function()
        menu.Visible = not menu.Visible
        toggleButton.Visible = not menu.Visible
    end)

    -- Кнопка для скрытия/показывания меню
    toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 30, 0, 30)
    toggleButton.Position = UDim2.new(0.5, -15, 1, -40)
    toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggleButton.Text = "||"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Parent = menu
    toggleButton.Visible = false

    toggleButton.MouseButton1Click:Connect(function()
        menu.Visible = not menu.Visible
        toggleButton.Visible = not menu.Visible
    end)

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 45)
    toggleCorner.Parent = toggleButton

    -- Перемещение меню
    local dragging = false
    local offset = Vector2.new(0, 0)

    menu.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            offset = input.Position - menu.Position
        end
    end)

    menu.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            menu.Position = UDim2.new(0, input.Position.X - offset.X, 0, input.Position.Y - offset.Y)
        end
    end)

    menu.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- Функция для добавления кнопок
local function addButton(name, text, onActive, onDeactivate)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, #buttons * 40 + 40)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = menu

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = btn

    table.insert(buttons, {button = btn, onActive = onActive, onDeactivate = onDeactivate})

    btn.MouseButton1Click:Connect(function()
        local buttonData = buttons[#buttons]
        if buttonData then
            if buttonData.onActive then
                buttonData.onActive()
            end
        end
    end)
end

-- Загрузка и обработка внешнего скрипта
local function loadExternalScript(url)
    local scriptContent = game:HttpGet(url)
    local externalScript = loadstring(scriptContent)
    if externalScript then
        local success, result = pcall(externalScript)
        if success then
            print("Script loaded and executed successfully")
        else
            warn("Failed to execute script: " .. result)
        end
    else
        warn("Failed to load script content.")
    end
end

-- Основной запуск
createMenu()

-- Пример загрузки скрипта и добавления кнопок
loadExternalScript("ссылка на этот скрипт сверху")

-- Пример добавления кнопок вручную (если нужно)
addButton("text", "Button 1", function() print("yuy") end, function() print("hjhh") end)
