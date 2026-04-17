-- ==========================================
-- BLOXY HUB - UI CON ICONOS TEMÁTICOS, FPS, PING Y HORA
-- ==========================================

local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local guiName = "BloxyHub_UI"
local blurName = "BloxyHub_Blur"
local configFileName = "BloxyHub_Keybind.json"

-- ==========================================
-- SISTEMA DE GUARDADO (CONFIG)
-- ==========================================
local currentKeybind = Enum.KeyCode.LeftAlt
local is24HourFormat = false -- Variable para el formato de hora

local function loadConfig()
    if isfile and readfile and isfile(configFileName) then
        local success, result = pcall(function() return HttpService:JSONDecode(readfile(configFileName)) end)
        if success and result then
            if result.Keybind then
                local savedKey = Enum.KeyCode[result.Keybind]
                if savedKey then currentKeybind = savedKey end
            end
            if result.Format24H ~= nil then
                is24HourFormat = result.Format24H
            end
        end
    end
end

local function saveConfig()
    if writefile then
        local data = { 
            Keybind = currentKeybind.Name,
            Format24H = is24HourFormat
        }
        writefile(configFileName, HttpService:JSONEncode(data))
    end
end

loadConfig()

-- ==========================================
-- 1. LIMPIEZA PREVIA
-- ==========================================
local targetParent = pcall(function() return CoreGui.Name end) and CoreGui or LocalPlayer:WaitForChild("PlayerGui")
if targetParent:FindFirstChild(guiName) then targetParent[guiName]:Destroy() end
if Lighting:FindFirstChild(blurName) then Lighting[blurName]:Destroy() end

-- ==========================================
-- 2. CREAR INTERFAZ BASE (ESTILO AERO GLASS)
-- ==========================================
local Blur = Instance.new("BlurEffect")
Blur.Name = blurName
Blur.Size = 0
Blur.Parent = Lighting

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = guiName
ScreenGui.Parent = targetParent
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local DarkOverlay = Instance.new("Frame")
DarkOverlay.Size = UDim2.new(1, 0, 1, 0)
DarkOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
DarkOverlay.BackgroundTransparency = 1
DarkOverlay.BorderSizePixel = 0
DarkOverlay.ZIndex = 1
DarkOverlay.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 320)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 1 
MainFrame.BorderSizePixel = 0
MainFrame.ZIndex = 2
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 1.2
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Transparency = 1 
UIStroke.Parent = MainFrame

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 150))
})
UIGradient.Rotation = 45 
UIGradient.Parent = MainFrame

-- ==========================================
-- BARRA SUPERIOR (TOPBAR REORGANIZADA)
-- ==========================================
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -120, 0, 40)
Title.Position = UDim2.new(0, 15, 0, 0) 
Title.BackgroundTransparency = 1
Title.Text = "BLOXY HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextTransparency = 1
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3
Title.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextTransparency = 1
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.ZIndex = 3
CloseBtn.Parent = MainFrame

local SettingsBtn = Instance.new("ImageButton")
SettingsBtn.Size = UDim2.new(0, 24, 0, 24)
SettingsBtn.Position = UDim2.new(1, -65, 0, 8) 
SettingsBtn.BackgroundTransparency = 1
SettingsBtn.Image = "rbxassetid://6031280882" 
SettingsBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)
SettingsBtn.ImageTransparency = 1
SettingsBtn.ZIndex = 3
SettingsBtn.Parent = MainFrame

local DiscordBtn = Instance.new("ImageButton")
DiscordBtn.Size = UDim2.new(0, 28, 0, 28)
DiscordBtn.Position = UDim2.new(1, -100, 0, 6) 
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordBtn.Image = "rbxassetid://13028574346" 
DiscordBtn.ImageTransparency = 1
DiscordBtn.BackgroundTransparency = 1
DiscordBtn.AutoButtonColor = false 
DiscordBtn.ZIndex = 3
DiscordBtn.Parent = MainFrame

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 6)
DiscordCorner.Parent = DiscordBtn

local TopSeparator = Instance.new("Frame")
TopSeparator.Size = UDim2.new(1, 0, 0, 1)
TopSeparator.Position = UDim2.new(0, 0, 0, 40) 
TopSeparator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TopSeparator.BackgroundTransparency = 1
TopSeparator.BorderSizePixel = 0
TopSeparator.ZIndex = 3
TopSeparator.Parent = MainFrame

-- ==========================================
-- BARRA INFERIOR (PERFIL Y ESTADÍSTICAS)
-- ==========================================
local BottomSeparator = Instance.new("Frame")
BottomSeparator.Size = UDim2.new(1, 0, 0, 1)
BottomSeparator.Position = UDim2.new(0, 0, 1, -40) 
BottomSeparator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BottomSeparator.BackgroundTransparency = 1
BottomSeparator.BorderSizePixel = 0
BottomSeparator.ZIndex = 3
BottomSeparator.Parent = MainFrame

local ProfilePic = Instance.new("ImageLabel")
ProfilePic.Size = UDim2.new(0, 26, 0, 26)
ProfilePic.Position = UDim2.new(0, 12, 1, -33)
ProfilePic.BackgroundTransparency = 1
ProfilePic.ImageTransparency = 1
ProfilePic.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
ProfilePic.ZIndex = 3
ProfilePic.Parent = MainFrame

local ProfileCorner = Instance.new("UICorner")
ProfileCorner.CornerRadius = UDim.new(1, 0)
ProfileCorner.Parent = ProfilePic

local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Size = UDim2.new(0.3, 0, 0, 40) 
UsernameLabel.Position = UDim2.new(0, 45, 1, -40)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Text = LocalPlayer.DisplayName
UsernameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
UsernameLabel.TextTransparency = 1
UsernameLabel.Font = Enum.Font.GothamSemibold
UsernameLabel.TextSize = 13
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.TextTruncate = Enum.TextTruncate.AtEnd
UsernameLabel.ZIndex = 3
UsernameLabel.Parent = MainFrame

local StatsLabel = Instance.new("TextLabel")
StatsLabel.Size = UDim2.new(0.4, 0, 0, 40) 
StatsLabel.Position = UDim2.new(0.3, 0, 1, -40)
StatsLabel.BackgroundTransparency = 1
StatsLabel.Text = "Cargando..."
StatsLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
StatsLabel.TextTransparency = 1
StatsLabel.Font = Enum.Font.Gotham
StatsLabel.TextSize = 12
StatsLabel.TextXAlignment = Enum.TextXAlignment.Center 
StatsLabel.ZIndex = 3
StatsLabel.Parent = MainFrame

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Size = UDim2.new(0.3, -15, 0, 40)
TimeLabel.Position = UDim2.new(0.7, 0, 1, -40)
TimeLabel.BackgroundTransparency = 1
TimeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
TimeLabel.TextTransparency = 1
TimeLabel.Font = Enum.Font.Gotham
TimeLabel.TextSize = 13
TimeLabel.TextXAlignment = Enum.TextXAlignment.Right
TimeLabel.ZIndex = 3
TimeLabel.Parent = MainFrame

local function updateTimeDisplay()
    local formatStr = is24HourFormat and "%H:%M" or "%I:%M %p"
    TimeLabel.Text = os.date(formatStr)
end
updateTimeDisplay() -- Carga inicial al instante

-- ==========================================
-- ACTUALIZADOR DE ESTADÍSTICAS RÁPIDAS
-- ==========================================
task.spawn(function()
    while task.wait(1) do
        if TimeLabel then updateTimeDisplay() end
    end
end)

local lastTime = tick()
local frameCount = 0

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local currentTime = tick()
    
    if currentTime - lastTime >= 0.1 then 
        local fps = math.floor(frameCount / (currentTime - lastTime))
        frameCount = 0
        lastTime = currentTime
        
        local ping = 0
        pcall(function()
            ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
        end)
        
        if StatsLabel then
            StatsLabel.Text = fps .. " FPS | " .. ping .. " ms"
        end
    end
end)

-- ==========================================
-- PÁGINAS DEL MENÚ
-- ==========================================
local isUiVisible = true 
local inSettings = false

local HomeFrame = Instance.new("Frame")
HomeFrame.Size = UDim2.new(1, -20, 1, -95) 
HomeFrame.Position = UDim2.new(0, 10, 0, 55) 
HomeFrame.BackgroundTransparency = 1
HomeFrame.Parent = MainFrame

local HomeLayout = Instance.new("UIListLayout")
HomeLayout.Padding = UDim.new(0, 8)
HomeLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
HomeLayout.Parent = HomeFrame

local function createScriptButton(name, text, parent, iconId)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0.9, 0, 0, 35) 
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 1
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextTransparency = 1
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 13 
    btn.AutoButtonColor = false
    btn.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    if iconId then
        local icon = Instance.new("ImageLabel")
        icon.Name = "BtnIcon"
        icon.Size = UDim2.new(0, 20, 0, 20)
        icon.Position = UDim2.new(0, 15, 0.5, -10)
        icon.BackgroundTransparency = 1
        icon.Image = iconId
        icon.ImageTransparency = 1
        icon.Parent = btn
        
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 20)
        padding.Parent = btn
    end
    
    btn.MouseEnter:Connect(function() 
        if isUiVisible and btn.TextTransparency < 0.5 then 
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play() 
        end
    end)
    btn.MouseLeave:Connect(function() 
        if isUiVisible and btn.TextTransparency < 0.5 then 
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play() 
        end
    end)
    
    return btn
end

local Script1Btn = createScriptButton("Script1", "Ejecutar BLOXY-MM2™", HomeFrame, "rbxassetid://7300465360")
local Script2Btn = createScriptButton("Script2", "Ejecutar BLOXY-E | A", HomeFrame, "rbxassetid://4731371541") 
local Script3Btn = createScriptButton("Script3", "Ejecutar BLOXY-RV", HomeFrame, "rbxassetid://8935402434") 

-- PÁGINA 2: AJUSTES
local SettingsFrame = Instance.new("Frame") 
SettingsFrame.Size = UDim2.new(1, -20, 1, -95)
SettingsFrame.Position = UDim2.new(0, 10, 0, 55)
SettingsFrame.BackgroundTransparency = 1
SettingsFrame.Visible = false 
SettingsFrame.Parent = MainFrame

local SettingsLayout = Instance.new("UIListLayout")
SettingsLayout.Padding = UDim.new(0, 8)
SettingsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center 
SettingsLayout.Parent = SettingsFrame

local SettingsLabel = Instance.new("TextLabel")
SettingsLabel.Size = UDim2.new(0.9, 0, 0, 20)
SettingsLabel.BackgroundTransparency = 1
SettingsLabel.Text = "Tecla para Ocultar/Mostrar la UI:"
SettingsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SettingsLabel.TextTransparency = 1
SettingsLabel.Font = Enum.Font.Gotham
SettingsLabel.TextSize = 13
SettingsLabel.TextXAlignment = Enum.TextXAlignment.Left
SettingsLabel.Parent = SettingsFrame

local KeybindBtn = createScriptButton("KeybindBtn", "Tecla Actual: " .. currentKeybind.Name, SettingsFrame)

-- NUEVO BOTÓN: FORMATO DE HORA
local TimeFormatBtn = createScriptButton("TimeFormatBtn", "Formato de Hora: " .. (is24HourFormat and "24H" or "12H"), SettingsFrame)

-- ==========================================
-- ANIMACIONES INDEPENDIENTES Y SEGURAS
-- ==========================================
local toggleTweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

-- Función de fade mejorada para evitar que los elementos desaparezcan permanentemente
local function fadeTabContent(tab, isShowing, duration)
    local tweenInfo = TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local targetTextTrans = isShowing and 0 or 1
    local targetBgTrans = isShowing and 0.5 or 1
    
    -- Asegurarnos de que el layout también se actualice visualmente
    for _, item in ipairs(tab:GetDescendants()) do
        if item:IsA("TextButton") then
            TweenService:Create(item, tweenInfo, {TextTransparency = targetTextTrans, BackgroundTransparency = targetBgTrans}):Play()
        elseif item:IsA("TextLabel") then
            TweenService:Create(item, tweenInfo, {TextTransparency = targetTextTrans}):Play()
        elseif item:IsA("ImageLabel") and item.Name == "BtnIcon" then
            TweenService:Create(item, tweenInfo, {ImageTransparency = targetTextTrans}):Play()
        end
    end
end

local function toggleUI(show)
    if show then
        MainFrame.Visible = true
        isUiVisible = true
        TweenService:Create(Blur, toggleTweenInfo, {Size = 25}):Play()
        TweenService:Create(DarkOverlay, toggleTweenInfo, {BackgroundTransparency = 0.4}):Play()
        TweenService:Create(MainFrame, toggleTweenInfo, {Size = UDim2.new(0, 500, 0, 320), BackgroundTransparency = 0.75}):Play()
    else
        isUiVisible = false
        TweenService:Create(Blur, toggleTweenInfo, {Size = 0}):Play()
        TweenService:Create(DarkOverlay, toggleTweenInfo, {BackgroundTransparency = 1}):Play()
        TweenService:Create(MainFrame, toggleTweenInfo, {Size = UDim2.new(0, 450, 0, 290), BackgroundTransparency = 1}):Play()
    end

    local t1 = show and 0 or 1 
    
    TweenService:Create(UIStroke, toggleTweenInfo, {Transparency = show and 0.5 or 1}):Play()
    TweenService:Create(Title, toggleTweenInfo, {TextTransparency = t1}):Play()
    TweenService:Create(CloseBtn, toggleTweenInfo, {TextTransparency = t1}):Play()
    TweenService:Create(SettingsBtn, toggleTweenInfo, {ImageTransparency = t1}):Play()
    TweenService:Create(TopSeparator, toggleTweenInfo, {BackgroundTransparency = show and 0.6 or 1}):Play()
    TweenService:Create(DiscordBtn, toggleTweenInfo, {ImageTransparency = t1, BackgroundTransparency = t1}):Play()
    
    TweenService:Create(BottomSeparator, toggleTweenInfo, {BackgroundTransparency = show and 0.6 or 1}):Play()
    TweenService:Create(ProfilePic, toggleTweenInfo, {ImageTransparency = t1}):Play()
    TweenService:Create(UsernameLabel, toggleTweenInfo, {TextTransparency = t1}):Play()
    TweenService:Create(StatsLabel, toggleTweenInfo, {TextTransparency = t1}):Play()
    TweenService:Create(TimeLabel, toggleTweenInfo, {TextTransparency = t1}):Play()

    local activeTab = inSettings and SettingsFrame or HomeFrame
    fadeTabContent(activeTab, show, 0.4)

    if not show then
        task.delay(0.4, function()
            if not isUiVisible then MainFrame.Visible = false end
        end)
    end
end

-- ==========================================
-- LÓGICA DE BOTONES Y SISTEMAS
-- ==========================================

Script1Btn.MouseButton1Click:Connect(function()
    toggleUI(false)
    print("Ejecutando BLOXY-MM2™...")
    loadstring(game:HttpGet("https://gist.githubusercontent.com/Cooprince593/9ef7846b95a0d0aec2342a90eaac6bb6/raw/a04e209670d8f87116c00669be36b6e9f68337e2/Bloxy-MM2.lua"))()
end)

Script2Btn.MouseButton1Click:Connect(function()
    toggleUI(false)
    print("Ejecutando BLOXY-E | A...")
    loadstring(game:HttpGet("https://gist.githubusercontent.com/Cooprince593/4a9c1b6ed53820a57afd6cf364de67d0/raw/478141966c8dbd98bf46636c7736770a268f4cee/Bloxy-E%2520%257C%2520A.lua"))()
end)

Script3Btn.MouseButton1Click:Connect(function()
    toggleUI(false)
    print("Ejecutando BLOXY-RV...")
    loadstring(game:HttpGet("https://gist.githubusercontent.com/Cooprince593/97a68c256e1cdf0f7d597749a1f5395e/raw/8af46c2eb9008ef7bef7f05175ef56784a219470/BLOXY-RV.lua"))()
end)

SettingsBtn.MouseButton1Click:Connect(function()
    if not isUiVisible then return end
    inSettings = not inSettings
    TweenService:Create(SettingsBtn, TweenInfo.new(0.3), {Rotation = inSettings and 90 or 0}):Play()
    
    local activeTab = inSettings and SettingsFrame or HomeFrame
    local inactiveTab = inSettings and HomeFrame or SettingsFrame
    
    -- Fade out de la hoja inactiva primero
    fadeTabContent(inactiveTab, false, 0.2)
    
    -- Esperamos a que se desvanezca, ocultamos, mostramos la nueva y hacemos fade in
    task.delay(0.2, function()
        inactiveTab.Visible = false
        activeTab.Visible = true
        fadeTabContent(activeTab, true, 0.2)
    end)
end)

local isBinding = false
KeybindBtn.MouseButton1Click:Connect(function()
    isBinding = true
    KeybindBtn.Text = "Presiona una tecla..."
    TweenService:Create(KeybindBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(88, 101, 242)}):Play()
end)

TimeFormatBtn.MouseButton1Click:Connect(function()
    is24HourFormat = not is24HourFormat
    TimeFormatBtn.Text = "Formato de Hora: " .. (is24HourFormat and "24H" or "12H")
    updateTimeDisplay() -- Actualiza al instante
    saveConfig() -- Guarda la preferencia
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if isBinding and input.UserInputType == Enum.UserInputType.Keyboard then
        currentKeybind = input.KeyCode
        isBinding = false
        KeybindBtn.Text = "Tecla Actual: " .. currentKeybind.Name
        TweenService:Create(KeybindBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        saveConfig()
        return
    end
    
    if input.KeyCode == currentKeybind and not isBinding then
        toggleUI(not isUiVisible)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    toggleUI(false)
    task.wait(0.4)
    ScreenGui:Destroy()
    Blur:Destroy()
end)

CloseBtn.MouseEnter:Connect(function() if isUiVisible then TweenService:Create(CloseBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 80, 80)}):Play() end end)
CloseBtn.MouseLeave:Connect(function() if isUiVisible then TweenService:Create(CloseBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play() end end)
SettingsBtn.MouseEnter:Connect(function() if isUiVisible then TweenService:Create(SettingsBtn, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(200, 200, 200)}):Play() end end)
SettingsBtn.MouseLeave:Connect(function() if isUiVisible then TweenService:Create(SettingsBtn, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play() end end)

DiscordBtn.MouseEnter:Connect(function()
    if isUiVisible then TweenService:Create(DiscordBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(114, 137, 218)}):Play() end
end)
DiscordBtn.MouseLeave:Connect(function()
    if isUiVisible then TweenService:Create(DiscordBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(88, 101, 242)}):Play() end
end)

-- ==========================================
-- SISTEMA DE ARRASTRE
-- ==========================================
local dragging, dragInput, dragStart, startPos
local lastDelta = Vector2.new(0, 0)

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        lastDelta = Vector2.new(0, 0)
    end
end)

Title.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            dragging = false
            local targetPos = UDim2.new(
                MainFrame.Position.X.Scale, MainFrame.Position.X.Offset + (lastDelta.X * 15),
                MainFrame.Position.Y.Scale, MainFrame.Position.Y.Offset + (lastDelta.Y * 15)
            )
            TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = targetPos}):Play()
        end
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        lastDelta = input.Delta 
        local currentPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        TweenService:Create(MainFrame, TweenInfo.new(0.08, Enum.EasingStyle.Linear), {Position = currentPos}):Play()
    end
end)

-- ==========================================
-- EJECUCIÓN INICIAL
-- ==========================================
MainFrame.Size = UDim2.new(0, 450, 0, 290)
MainFrame.Visible = false
task.wait(0.1) 
toggleUI(true)
