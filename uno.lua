local Env = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

GetIcon = function(i)
    if type(i) == "string" and not i:find("rbxassetid://") then
        return "rbxassetid://" .. i
    elseif type(i) == "number" then
        return "rbxassetid://" .. i
    else
        return i
    end
end

tw = function(info)
    return TweenService:Create(
        info.v,
        TweenInfo.new(info.t, Enum.EasingStyle[info.s], Enum.EasingDirection[info.d]),
        info.g
    )
end

lak = function(a)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil

    local function Update(input)
        local Delta = input.Position - DragStart
        local pos =
            UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
        local Tween =
            TweenService:Create(
            a,
            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = pos}
        )
        Tween:Play()
    end

    a.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = input.Position
                StartPosition = a.Position

                input.Changed:Connect(
                    function()
                        if input.UserInputState == Enum.UserInputState.End then
                            Dragging = false
                        end
                    end
                )
            end
        end
    )

    a.InputChanged:Connect(
        function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseMovement or
                    input.UserInputType == Enum.UserInputType.Touch
             then
                DragInput = input
            end
        end
    )

    UserInputService.InputChanged:Connect(
        function(input)
            if input == DragInput and Dragging then
                Update(input)
            end
        end
    )
end

click = function(p)
    local Click = Instance.new("TextButton")
    Click.Name = "Click"
    Click.Parent = p
    Click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Click.BackgroundTransparency = 1
    Click.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Click.BorderSizePixel = 0
    Click.Size = UDim2.new(1, 0, 1, 0)
    Click.Font = Enum.Font.SourceSans
    Click.Text = ""
    Click.TextColor3 = Color3.fromRGB(0, 0, 0)
    Click.TextSize = 14
    Click.ZIndex = p.ZIndex + 2
    return Click
end

EffectClick = function(c, p)
    local Mouse = LocalPlayer:GetMouse()
    local relativeX = Mouse.X - c.AbsolutePosition.X
    local relativeY = Mouse.Y - c.AbsolutePosition.Y

    if relativeX < 0 or relativeY < 0 or relativeX > c.AbsoluteSize.X or relativeY > c.AbsoluteSize.Y then
        return
    end

    local ClickButtonCircle = Instance.new("Frame")
    ClickButtonCircle.Parent = p
    ClickButtonCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ClickButtonCircle.BackgroundTransparency = 0.4
    ClickButtonCircle.BorderSizePixel = 0
    ClickButtonCircle.AnchorPoint = Vector2.new(0.5, 0.5)
    ClickButtonCircle.Position = UDim2.new(0, relativeX, 0, relativeY)
    ClickButtonCircle.Size = UDim2.new(0, 0, 0, 0)
    ClickButtonCircle.ZIndex = p.ZIndex + 1

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = ClickButtonCircle

    local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local goal = {
        Size = UDim2.new(0, c.AbsoluteSize.X * 1.8, 0, c.AbsoluteSize.X * 1.8),
        BackgroundTransparency = 1
    }
    local expandTween = TweenService:Create(ClickButtonCircle, tweenInfo, goal)
    expandTween.Completed:Connect(
        function()
            ClickButtonCircle:Destroy()
        end
    )
    expandTween:Play()
end

local Unique = Instance.new("ScreenGui")
Unique.Name = "Unique"
Unique.Parent = not game:GetService("RunService"):IsStudio() and game:GetService("CoreGui") or LocalPlayer.PlayerGui
Unique.ZIndexBehavior = Enum.ZIndexBehavior.Global
Unique.IgnoreGuiInset = true

function Env:Window(meta)
    local Logo = meta.Logo
    local Bind = meta.Bind or Enum.KeyCode.Q
    local PrimaryColor = meta.PrimaryColor or Color3.fromRGB(20, 20, 20)
    local WindowSize = meta.Size or UDim2.new(0, 600, 0, 450)

    local Background_1 = Instance.new("Frame")
    local DropShadowHolder = Instance.new("Frame")
    local DropShadow_1 = Instance.new("ImageLabel")
    local Logo_1 = Instance.new("ImageLabel")
    local UIGradient_1 = Instance.new("UIGradient")
    local UICorner_1 = Instance.new("UICorner")
    local Header_1 = Instance.new("Frame")
    local LogoHead_1 = Instance.new("Frame")
    local RealLogo_1 = Instance.new("ImageLabel")
    local UIListLayout_1 = Instance.new("UIListLayout")
    local Tabs_1 = Instance.new("Frame")
    local Tablist_1 = Instance.new("ScrollingFrame")
    local UIListLayout_2 = Instance.new("UIListLayout")
    local Footer_1 = Instance.new("Frame")
    local FooterAvatar = Instance.new("ImageLabel")
    local FooterName = Instance.new("TextLabel")
    local FooterTime = Instance.new("TextLabel")
    local UICorner_Footer = Instance.new("UICorner")
    local UIGradient_Footer = Instance.new("UIGradient")

    Background_1.Name = "Background"
    Background_1.Parent = Unique
    Background_1.AnchorPoint = Vector2.new(0.5, 0.5)
    Background_1.BackgroundColor3 = PrimaryColor
    Background_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Background_1.BorderSizePixel = 0
    Background_1.Position = UDim2.new(0.5, 0, 0.5, 0)
    Background_1.Size = WindowSize
    Background_1.ClipsDescendants = true

    lak(Background_1)

    DropShadowHolder.Name = "DropShadowHolder"
    DropShadowHolder.Parent = Background_1
    DropShadowHolder.BackgroundTransparency = 1
    DropShadowHolder.BorderSizePixel = 0
    DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
    DropShadowHolder.ZIndex = 0

    DropShadow_1.Name = "DropShadow"
    DropShadow_1.Parent = DropShadowHolder
    DropShadow_1.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow_1.BackgroundTransparency = 1
    DropShadow_1.BorderSizePixel = 0
    DropShadow_1.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow_1.Size = UDim2.new(1, 60, 1, 60)
    DropShadow_1.ZIndex = 0
    DropShadow_1.Image = "rbxassetid://6014261993"
    DropShadow_1.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow_1.ImageTransparency = 0.5
    DropShadow_1.ScaleType = Enum.ScaleType.Slice
    DropShadow_1.SliceCenter = Rect.new(49, 49, 450, 450)

    local CloseUI = Instance.new("TextButton")
    local UICorner_1z = Instance.new("UICorner")
    local Icon_1 = Instance.new("Frame")
    local ImageLabel = Instance.new("ImageLabel")

    CloseUI.Name = "CloseUI"
    CloseUI.Parent = Unique
    CloseUI.AnchorPoint = Vector2.new(0, 1)
    CloseUI.BackgroundColor3 = PrimaryColor
    CloseUI.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CloseUI.BorderSizePixel = 0
    CloseUI.Position = UDim2.new(0.5, 0, 0.1, 0)
    CloseUI.Size = UDim2.new(0, 50, 0, 50)
    CloseUI.BackgroundTransparency = 0.2
    CloseUI.Text = ""

    lak(CloseUI)

    UICorner_1z.Parent = CloseUI
    UICorner_1z.CornerRadius = UDim.new(0, 8)

    Icon_1.Name = "Icon"
    Icon_1.Parent = CloseUI
    Icon_1.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Icon_1.BackgroundTransparency = 1
    Icon_1.BorderSizePixel = 0
    Icon_1.Size = UDim2.new(0, 50, 0, 50)

    ImageLabel.Parent = Icon_1
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.Size = UDim2.new(0, 40, 0, 40)
    ImageLabel.Image = GetIcon(Logo)

    local function pixelDissolve(frame)
        local pixels = {}
        local pixelSize = 8
        local size = frame.AbsoluteSize
        local rows = math.ceil(size.Y / pixelSize)
        local cols = math.ceil(size.X / pixelSize)

        for row = 1, rows do
            for col = 1, cols do
                local pixel = Instance.new("Frame")
                pixel.BackgroundColor3 = frame.BackgroundColor3
                pixel.Size = UDim2.new(0, pixelSize, 0, pixelSize)
                pixel.Position = UDim2.new(0, (col - 1) * pixelSize, 0, (row - 1) * pixelSize)
                pixel.Parent = frame
                pixel.ZIndex = frame.ZIndex + 1
                table.insert(pixels, pixel)
            end
        end

        for _, pixel in ipairs(pixels) do
            local delay = math.random() * 0.5
            tw(
                {
                    v = pixel,
                    t = 0.5,
                    s = "Sine",
                    d = "Out",
                    g = {BackgroundTransparency = 1, Position = pixel.Position + UDim2.new(0, 0, 0, 20)}
                }
            ):Play()
            task.spawn(
                function()
                    task.wait(delay)
                    pixel:Destroy()
                end
            )
        end

        task.wait(0.6)
        frame.Visible = false
    end

    local function closeopenui()
        task.spawn(
            function()
                tw(
                    {
                        v = ImageLabel,
                        t = 0.15,
                        s = "Back",
                        d = "Out",
                        g = {Size = UDim2.new(0, 35, 0, 35)}
                    }
                ):Play()
                task.wait(0.1)
                tw(
                    {
                        v = ImageLabel,
                        t = 0.15,
                        s = "Back",
                        d = "Out",
                        g = {Size = UDim2.new(0, 40, 0, 40)}
                    }
                ):Play()
            end
        )
        if Background_1.Visible then
            pixelDissolve(Background_1)
        else
            Background_1.Visible = true
            tw(
                {
                    v = Background_1,
                    t = 0.3,
                    s = "Quad",
                    d = "Out",
                    g = {BackgroundTransparency = 0}
                }
            ):Play()
        end
    end

    local On = true
    CloseUI.MouseButton1Click:Connect(
        function()
            closeopenui()
            On = not On
        end
    )

    UserInputService.InputBegan:Connect(
        function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == Bind then
                closeopenui()
                On = not On
            end
        end
    )

    Logo_1.Name = "Logo"
    Logo_1.Parent = Background_1
    Logo_1.AnchorPoint = Vector2.new(0.5, 0.5)
    Logo_1.BackgroundTransparency = 1
    Logo_1.BorderSizePixel = 0
    Logo_1.Position = UDim2.new(0.5, 0, 0.5, 0)
    Logo_1.Size = UDim2.new(0, 300, 0, 300)
    Logo_1.Image = GetIcon(Logo)
    Logo_1.ImageTransparency = 0.7

    UIGradient_1.Parent = Logo_1
    UIGradient_1.Transparency =
        NumberSequence.new {
        NumberSequenceKeypoint.new(0, 0.3),
        NumberSequenceKeypoint.new(0.998753, 1),
        NumberSequenceKeypoint.new(1, 0)
    }
    UIGradient_1.Color =
        ColorSequence.new {ColorSequenceKeypoint.new(0, PrimaryColor), ColorSequenceKeypoint.new(1, PrimaryColor)}

    UICorner_1.Parent = Background_1
    UICorner_1.CornerRadius = UDim.new(0, 12)

    Header_1.Name = "Header"
    Header_1.Parent = Background_1
    Header_1.BackgroundTransparency = 1
    Header_1.BorderSizePixel = 0
    Header_1.Size = UDim2.new(0, 80, 0, WindowSize.Y.Offset - 60)

    LogoHead_1.Name = "LogoHead"
    LogoHead_1.Parent = Header_1
    LogoHead_1.BackgroundTransparency = 1
    LogoHead_1.BorderSizePixel = 0
    LogoHead_1.Size = UDim2.new(0, 50, 0, 50)

    RealLogo_1.Name = "RealLogo"
    RealLogo_1.Parent = LogoHead_1
    RealLogo_1.AnchorPoint = Vector2.new(0.5, 0.5)
    RealLogo_1.BackgroundTransparency = 1
    RealLogo_1.BorderSizePixel = 0
    RealLogo_1.Position = UDim2.new(0.5, 0, 0.5, 0)
    RealLogo_1.Size = UDim2.new(0.9, 0, 0.9, 0)
    RealLogo_1.Image = GetIcon(Logo)
    RealLogo_1.ScaleType = Enum.ScaleType.Fit

    UIListLayout_1.Parent = Header_1
    UIListLayout_1.Padding = UDim.new(0, 8)
    UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center

    Tabs_1.Name = "Tabs"
    Tabs_1.Parent = Header_1
    Tabs_1.BackgroundTransparency = 1
    Tabs_1.BorderSizePixel = 0
    Tabs_1.Position = UDim2.new(0, 0, 0.184, 0)
    Tabs_1.Size = UDim2.new(0, 70, 0, Header_1.Size.Y.Offset - 60)

    Tablist_1.Name = "Tablist"
    Tablist_1.Parent = Tabs_1
    Tablist_1.Active = true
    Tablist_1.AnchorPoint = Vector2.new(0.5, 0.5)
    Tablist_1.BackgroundTransparency = 1
    Tablist_1.BorderSizePixel = 0
    Tablist_1.Position = UDim2.new(0.5, 0, 0.5, 0)
    Tablist_1.Size = UDim2.new(0.95, 0, 1, 0)
    Tablist_1.ClipsDescendants = true
    Tablist_1.ScrollBarThickness = 0

    UIListLayout_2.Parent = Tablist_1
    UIListLayout_2.Padding = UDim.new(0, 12)
    UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

    Footer_1.Name = "Footer"
    Footer_1.Parent = Background_1
    Footer_1.BackgroundColor3 = PrimaryColor
    Footer_1.BackgroundTransparency = 0.2
    Footer_1.BorderSizePixel = 0
    Footer_1.Position = UDim2.new(0, 0, 1, -40)
    Footer_1.Size = UDim2.new(1, 0, 0, 40)

    UICorner_Footer.Parent = Footer_1
    UICorner_Footer.CornerRadius = UDim.new(0, 8)

    UIGradient_Footer.Parent = Footer_1
    UIGradient_Footer.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
    }
    UIGradient_Footer.Transparency =
        NumberSequence.new {NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0.5)}

    FooterAvatar.Name = "Avatar"
    FooterAvatar.Parent = Footer_1
    FooterAvatar.BackgroundTransparency = 1
    FooterAvatar.Position = UDim2.new(0, 10, 0.5, -15)
    FooterAvatar.Size = UDim2.new(0, 30, 0, 30)
    FooterAvatar.Image =
        Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size48x48)
    FooterAvatar.ImageTransparency = 0.1

    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(1, 0)
    AvatarCorner.Parent = FooterAvatar

    FooterName.Name = "Name"
    FooterName.Parent = Footer_1
    FooterName.BackgroundTransparency = 1
    FooterName.Position = UDim2.new(0, 50, 0.5, -10)
    FooterName.Size = UDim2.new(0, 200, 0, 20)
    FooterName.Font = Enum.Font.GothamBold
    FooterName.Text = LocalPlayer.Name
    FooterName.TextColor3 = Color3.fromRGB(255, 255, 255)
    FooterName.TextSize = 14
    FooterName.TextXAlignment = Enum.TextXAlignment.Left
    FooterName.TextTransparency = 0.1

    FooterTime.Name = "Time"
    FooterTime.Parent = Footer_1
    FooterTime.BackgroundTransparency = 1
    FooterTime.Position = UDim2.new(1, -120, 0.5, -10)
    FooterTime.Size = UDim2.new(0, 100, 0, 20)
    FooterTime.Font = Enum.Font.GothamMedium
    FooterTime.Text = os.date("%d/%m/%Y %H:%M")
    FooterTime.TextColor3 = Color3.fromRGB(200, 200, 200)
    FooterTime.TextSize = 12
    FooterTime.TextXAlignment = Enum.TextXAlignment.Right
    FooterTime.TextTransparency = 0.3

    spawn(
        function()
            while true do
                FooterTime.Text = os.date("%d/%m/%Y %H:%M")
                task.wait(60)
            end
        end
    )

    local Line_1 = Instance.new("Frame")
    Line_1.Name = "Line"
    Line_1.Parent = Background_1
    Line_1.AnchorPoint = Vector2.new(0.5, 0.5)
    Line_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Line_1.BackgroundTransparency = 0.9
    Line_1.BorderSizePixel = 0
    Line_1.Position = UDim2.new(0.136, 0, 0.5, 0)
    Line_1.Size = UDim2.new(0, 1, 0.85, 0)

    Env.Tab = {Value = false}

    function Env.Tab:Tab(icon)
        local AddList_1 = Instance.new("Frame")
        local Clicktab = click(AddList_1)
        local UICorner_2 = Instance.new("UICorner")
        local UIGradient_2 = Instance.new("UIGradient")
        local Icon_1 = Instance.new("ImageLabel")
        local UIPadding_1 = Instance.new("UIPadding")
        local Page_1 = Instance.new("Frame")
        local UIListLayout_3 = Instance.new("UIListLayout")
        local Left_1 = Instance.new("ScrollingFrame")
        local UIListLayout_4 = Instance.new("UIListLayout")
        local UIPadding_2 = Instance.new("UIPadding")

        AddList_1.Name = "AddList"
        AddList_1.Parent = Tablist_1
        AddList_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        AddList_1.BackgroundTransparency = 0.9
        AddList_1.BorderSizePixel = 0
        AddList_1.Size = UDim2.new(0, 50, 0, 50)

        UICorner_2.Parent = AddList_1
        UICorner_2.CornerRadius = UDim.new(0, 15)

        UIGradient_2.Parent = AddList_1
        UIGradient_2.Color =
            ColorSequence.new {
            ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 140, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 180, 255))
        }
        UIGradient_2.Rotation = -135

        Icon_1.Name = "Icon"
        Icon_1.Parent = AddList_1
        Icon_1.AnchorPoint = Vector2.new(0.5, 0.5)
        Icon_1.BackgroundTransparency = 1
        Icon_1.BorderSizePixel = 0
        Icon_1.Position = UDim2.new(0.5, 0, 0.5, 0)
        Icon_1.Size = UDim2.new(0.6, 0, 0.6, 0)
        Icon_1.Image = GetIcon(icon)
        Icon_1.ImageTransparency = 0.7

        UIPadding_1.Parent = Tablist_1
        UIPadding_1.PaddingTop = UDim.new(0, 8)

        Page_1.Name = "Page"
        Page_1.Parent = Background_1
        Page_1.AnchorPoint = Vector2.new(0.5, 0.5)
        Page_1.BackgroundTransparency = 1
        Page_1.BorderSizePixel = 0
        Page_1.Position = UDim2.new(0.5685, 0, 0.5, 0)
        Page_1.Size = UDim2.new(0.86, 1, 0.85, 0)
        Page_1.Visible = false

        UIListLayout_3.Parent = Page_1
        UIListLayout_3.Padding = UDim.new(0, 5)
        UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
        UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_3.VerticalAlignment = Enum.VerticalAlignment.Center

        Left_1.Name = "Left"
        Left_1.Parent = Page_1
        Left_1.Active = true
        Left_1.BackgroundTransparency = 1
        Left_1.BorderSizePixel = 0
        Left_1.Size = UDim2.new(0, 230, 0.95, 0)
        Left_1.ScrollBarThickness = 0

        UIListLayout_4.Parent = Left_1
        UIListLayout_4.Padding = UDim.new(0, 12)
        UIListLayout_4.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder

        local Right_1 = Instance.new("ScrollingFrame")
        local UIListLayout_6 = Instance.new("UIListLayout")
        local UIPadding_3 = Instance.new("UIPadding")

        Right_1.Name = "Right"
        Right_1.Parent = Page_1
        Right_1.Active = true
        Right_1.BackgroundTransparency = 1
        Right_1.BorderSizePixel = 0
        Right_1.Size = UDim2.new(0, 230, 0.95, 0)
        Right_1.ScrollBarThickness = 0

        UIListLayout_6.Parent = Right_1
        UIListLayout_6.Padding = UDim.new(0, 12)
        UIListLayout_6.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout_6.SortOrder = Enum.SortOrder.LayoutOrder

        UIPadding_3.Parent = Right_1
        UIPadding_3.PaddingTop = UDim.new(0, 2)

        UIPadding_2.Parent = Left_1
        UIPadding_2.PaddingTop = UDim.new(0, 2)

        Clicktab.MouseButton1Click:Connect(
            function()
                for _, v in pairs(Background_1:GetChildren()) do
                    if v.Name == "Page" then
                        v.Visible = false
                    end
                end
                for _, v in pairs(Tablist_1:GetChildren()) do
                    if v:IsA("Frame") then
                        tw(
                            {
                                v = v,
                                t = 0.25,
                                s = "Quad",
                                d = "Out",
                                g = {BackgroundTransparency = 0.9}
                            }
                        ):Play()
                        tw(
                            {
                                v = v.Icon,
                                t = 0.25,
                                s = "Quad",
                                d = "Out",
                                g = {ImageTransparency = 0.7}
                            }
                        ):Play()
                    end
                end
                Page_1.Visible = true
                Page_1.Size = UDim2.new(0, 0, 0, 0)
                tw(
                    {
                        v = Page_1,
                        t = 0.3,
                        s = "Sine",
                        d = "Out",
                        g = {Size = UDim2.new(0.86, 1, 0.85, 0)}
                    }
                ):Play()
                tw(
                    {
                        v = AddList_1,
                        t = 0.25,
                        s = "Quad",
                        d = "Out",
                        g = {BackgroundTransparency = 0.2}
                    }
                ):Play()
                tw(
                    {
                        v = Icon_1,
                        t = 0.25,
                        s = "Quad",
                        d = "Out",
                        g = {ImageTransparency = 0}
                    }
                ):Play()
            end
        )

        delay(
            0.2,
            function()
                if not Env.Tab.Value then
                    tw(
                        {
                            v = AddList_1,
                            t = 0.25,
                            s = "Quad",
                            d = "Out",
                            g = {BackgroundTransparency = 0.2}
                        }
                    ):Play()
                    tw(
                        {
                            v = Icon_1,
                            t = 0.25,
                            s = "Quad",
                            d = "Out",
                            g = {ImageTransparency = 0}
                        }
                    ):Play()
                    Page_1.Visible = true
                    Page_1.Size = UDim2.new(0, 0, 0, 0)
                    tw(
                        {
                            v = Page_1,
                            t = 0.3,
                            s = "Sine",
                            d = "Out",
                            g = {Size = UDim2.new(0.86, 1, 0.85, 0)}
                        }
                    ):Play()
                    Env.Tab.Value = true
                end
            end
        )

        UIListLayout_6:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
            function()
                Right_1.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_6.AbsoluteContentSize.Y + 25)
            end
        )

        UIListLayout_4:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
            function()
                Left_1.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_4.AbsoluteContentSize.Y + 25)
            end
        )

        local function GetSide(side)
            if not side then
                return Left_1
            end
            local sideLower = string.lower(tostring(side))
            if sideLower == "r" or sideLower == "right" or side == 2 then
                return Right_1
            elseif sideLower == "l" or sideLower == "left" or side == 1 then
                return Left_1
            else
                return Left_1
            end
        end

        Env.Section = {}

        function Env.Class:Section(meta)
            local Title = meta.Title
            local Side = meta.Side

            local Section_1 = Instance.new("Frame")
            local UICorner_3 = Instance.new("UICorner")
            local UIListLayout_5 = Instance.new("UIListLayout")
            local Head_1 = Instance.new("Frame")
            local Title_1 = Instance.new("TextLabel")
            local Line_2 = Instance.new("Frame")

            Section_1.Name = "Section"
            Section_1.Parent = GetSide(Side)
            Section_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Section_1.BackgroundTransparency = 0.6
            Section_1.BorderSizePixel = 0
            Section_1.Size = UDim2.new(0.98, 0, 0, 100)

            UICorner_3.Parent = Section_1
            UICorner_3.CornerRadius = UDim.new(0, 6)

            UIListLayout_5.Parent = Section_1
            UIListLayout_5.Padding = UDim.new(0, 8)
            UIListLayout_5.HorizontalAlignment = Enum.HorizontalAlignment.Center
            UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder

            Head_1.Name = "Head"
            Head_1.Parent = Section_1
            Head_1.BackgroundTransparency = 1
            Head_1.BorderSizePixel = 0
            Head_1.Size = UDim2.new(1, 0, 0, 30)
            Head_1.LayoutOrder = -5

            Title_1.Name = "Title"
            Title_1.Parent = Head_1
            Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
            Title_1.BackgroundTransparency = 1
            Title_1.BorderSizePixel = 0
            Title_1.Position = UDim2.new(0.5, 0, 0.5, 0)
            Title_1.Size = UDim2.new(1, 0, 0, 14)
            Title_1.Font = Enum.Font.GothamBold
            Title_1.Text = Title
            Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title_1.TextSize = 14

            Line_2.Name = "Line"
            Line_2.Parent = Head_1
            Line_2.AnchorPoint = Vector2.new(0.5, 0.5)
            Line_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Line_2.BackgroundTransparency = 0.9
            Line_2.BorderSizePixel = 0
            Line_2.Position = UDim2.new(0.5, 0, 1, 0)
            Line_2.Size = UDim2.new(1, 0, 0, 1)

            UIListLayout_5:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                function()
                    Section_1.Size = UDim2.new(0.98, 0, 0, UIListLayout_5.AbsoluteContentSize.Y + 12)
                end
            )

            Env.Class = {}

            function Env.Class:Line()
                local Line_2 = Instance.new("Frame")
                Line_2.Name = "Line"
                Line_2.Parent = Section_1
                Line_2.AnchorPoint = Vector2.new(0.5, 0.5)
                Line_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Line_2.BackgroundTransparency = 0.9
                Line_2.BorderSizePixel = 0
                Line_2.Position = UDim2.new(0.5, 0, 1, 0)
                Line_2.Size = UDim2.new(1, 0, 0, 1)

                local i = {}
                function i:Visible(a)
                    Line_2.Visible = a
                end
                return i
            end

            function Env.Class:Button(a)
                local Title = a.Title
                local Callback = a.Callback

                local Button = Instance.new("Frame")
                local UICorner_1 = Instance.new("UICorner")
                local Title_1 = Instance.new("TextLabel")
                local Click = click(Button)
                local UIGradient = Instance.new("UIGradient")

                Button.Name = "Button"
                Button.Parent = Section_1
                Button.BackgroundColor3 = Color3.fromRGB(100, 140, 255)
                Button.BorderSizePixel = 0
                Button.Size = UDim2.new(0.95, 0, 0, 30)
                Button.ClipsDescendants = true

                UICorner_1.Parent = Button
                UICorner_1.CornerRadius = UDim.new(0, 6)

                UIGradient.Parent = Button
                UIGradient.Color =
                    ColorSequence.new {
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 140, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 180, 255))
                }
                UIGradient.Rotation = -135

                Title_1.Name = "Title"
                Title_1.Parent = Button
                Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Title_1.BackgroundTransparency = 1
                Title_1.BorderSizePixel = 0
                Title_1.Position = UDim2.new(0.5, 0, 0.5, 0)
                Title_1.Size = UDim2.new(1, 0, 0, 12)
                Title_1.Font = Enum.Font.GothamMedium
                Title_1.Text = Title
                Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title_1.TextSize = 12

                Click.MouseButton1Click:Connect(
                    function()
                        for _, v in pairs(Background_1:GetChildren()) do
                            if v.Name == "Dropdown" and v.Visible then
                                return
                            end
                        end
                        Callback()
                        EffectClick(Click, Button)
                    end
                )
            end

            function Env.Class:Toggle(meta)
                local Title = meta.Title
                local Value = meta.Value
                local Callback = meta.Callback

                local Togglec = Instance.new("Frame")
                local UICorner_1 = Instance.new("UICorner")
                local Title_1 = Instance.new("TextLabel")
                local Novalue_1 = Instance.new("Frame")
                local UICorner_2 = Instance.new("UICorner")
                local Color_1 = Instance.new("Frame")
                local UICorner_3 = Instance.new("UICorner")
                local UIGradient_1 = Instance.new("UIGradient")
                local Icon_1 = Instance.new("ImageLabel")
                local ClickToggle = click(Togglec)

                Togglec.Name = "Toggle"
                Togglec.Parent = Section_1
                Togglec.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Togglec.BackgroundTransparency = 0.9
                Togglec.BorderSizePixel = 0
                Togglec.Size = UDim2.new(0.95, 0, 0, 45)
                Togglec.ClipsDescendants = true

                UICorner_1.Parent = Togglec
                UICorner_1.CornerRadius = UDim.new(0, 6)

                Title_1.Name = "Title"
                Title_1.Parent = Togglec
                Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Title_1.BackgroundTransparency = 1
                Title_1.BorderSizePixel = 0
                Title_1.Position = UDim2.new(0.4, 0, 0.5, 0)
                Title_1.Size = UDim2.new(0.7, 0, 0, 12)
                Title_1.Font = Enum.Font.GothamMedium
                Title_1.Text = Title
                Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title_1.TextSize = 12
                Title_1.TextXAlignment = Enum.TextXAlignment.Left

                Novalue_1.Name = "Novalue"
                Novalue_1.Parent = Togglec
                Novalue_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Novalue_1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                Novalue_1.BorderSizePixel = 0
                Novalue_1.Position = UDim2.new(0.9, 0, 0.5, 0)
                Novalue_1.Size = UDim2.new(0, 28, 0, 28)

                UICorner_2.Parent = Novalue_1
                UICorner_2.CornerRadius = UDim.new(1, 0)

                Color_1.Name = "Color"
                Color_1.Parent = Novalue_1
                Color_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Color_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Color_1.BorderSizePixel = 0
                Color_1.BackgroundTransparency = 1
                Color_1.Position = UDim2.new(0.5, 0, 0.5, 0)
                Color_1.Size = UDim2.new(1, 0, 1, 0)

                UICorner_3.Parent = Color_1
                UICorner_3.CornerRadius = UDim.new(1, 0)

                UIGradient_1.Parent = Color_1
                UIGradient_1.Color =
                    ColorSequence.new {
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 140, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 180, 255))
                }
                UIGradient_1.Rotation = -135

                Icon_1.Name = "Icon"
                Icon_1.Parent = Color_1
                Icon_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Icon_1.BackgroundTransparency = 1
                Icon_1.BorderSizePixel = 0
                Icon_1.Position = UDim2.new(0.5, 0, 0.5, 0)
                Icon_1.Size = UDim2.new(0, 0, 0, 0)
                Icon_1.Image = "rbxassetid://99035215947422"

                local function Togglex(Value)
                    if not Value then
                        Callback(Value)
                        tw(
                            {
                                v = Color_1,
                                t = 0.4,
                                s = "Sine",
                                d = "Out",
                                g = {BackgroundTransparency = 1}
                            }
                        ):Play()
                        tw(
                            {
                                v = Icon_1,
                                t = 0.2,
                                s = "Sine",
                                d = "Out",
                                g = {Size = UDim2.new(0, 0, 0, 0)}
                            }
                        ):Play()
                    else
                        Callback(Value)
                        tw(
                            {
                                v = Color_1,
                                t = 0.4,
                                s = "Sine",
                                d = "Out",
                                g = {BackgroundTransparency = 0}
                            }
                        ):Play()
                        tw(
                            {
                                v = Icon_1,
                                t = 0.15,
                                s = "Bounce",
                                d = "Out",
                                g = {Size = UDim2.new(0.7, 0, 0.7, 0)}
                            }
                        ):Play()
                        delay(
                            0.1,
                            function()
                                tw(
                                    {
                                        v = Icon_1,
                                        t = 0.15,
                                        s = "Bounce",
                                        d = "Out",
                                        g = {Size = UDim2.new(0.5, 0, 0.5, 0)}
                                    }
                                ):Play()
                            end
                        )
                    end
                end

                ClickToggle.MouseButton1Click:Connect(
                    function()
                        for _, v in pairs(Background_1:GetChildren()) do
                            if v.Name == "Dropdown" and v.Visible then
                                return
                            end
                        end
                        EffectClick(ClickToggle, Togglec)
                        Value = not Value
                        Togglex(Value)
                    end
                )

                Togglex(Value)

                local i = {}
                function i:Value(v)
                    Value = v
                    Togglex(Value)
                end
                function i:Visible(v)
                    Togglec.Visible = v
                end
                return i
            end

            function Env.Class:Dropdown(info)
                local Title = info.Title
                local List = info.List or {}
                local Value = info.Value
                local Multi = info.Multi or false
                local Callback = info.Callback

                local Dropdownz = Instance.new("Frame")
                local UICorner_1 = Instance.new("UICorner")
                local Title_1 = Instance.new("TextLabel")
                local Icon_1 = Instance.new("ImageLabel")
                local Desc_1 = Instance.new("TextLabel")
                local ClickDropdown = click(Dropdownz)

                Dropdownz.Name = "Dropdown"
                Dropdownz.Parent = Section_1
                Dropdownz.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Dropdownz.BackgroundTransparency = 0.9
                Dropdownz.BorderSizePixel = 0
                Dropdownz.Size = UDim2.new(0.95, 0, 0, 45)
                Dropdownz.ClipsDescendants = true

                UICorner_1.Parent = Dropdownz
                UICorner_1.CornerRadius = UDim.new(0, 6)

                Title_1.Name = "Title"
                Title_1.Parent = Dropdownz
                Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Title_1.BackgroundTransparency = 1
                Title_1.BorderSizePixel = 0
                Title_1.Position = UDim2.new(0.4, 0, 0.35, 0)
                Title_1.Size = UDim2.new(0.7, 0, 0, 12)
                Title_1.Font = Enum.Font.GothamMedium
                Title_1.Text = Title
                Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title_1.TextSize = 12
                Title_1.TextXAlignment = Enum.TextXAlignment.Left

                Icon_1.Name = "Icon"
                Icon_1.Parent = Dropdownz
                Icon_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Icon_1.BackgroundTransparency = 1
                Icon_1.BorderSizePixel = 0
                Icon_1.Position = UDim2.new(0.9, 0, 0.5, 0)
                Icon_1.Size = UDim2.new(0, 24, 0, 24)
                Icon_1.Image = "rbxassetid://129573215183311"

                Desc_1.Name = "Desc"
                Desc_1.Parent = Dropdownz
                Desc_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Desc_1.BackgroundTransparency = 1
                Desc_1.BorderSizePixel = 0
                Desc_1.Position = UDim2.new(0.4, 0, 0.65, 0)
                Desc_1.Size = UDim2.new(0.7, 0, 0, 12)
                Desc_1.Font = Enum.Font.GothamMedium
                Desc_1.Text = type(Value) == "table" and "( . . . . . . )" or Value
                Desc_1.TextColor3 = Color3.fromRGB(255, 255, 255)
                Desc_1.TextSize = 11
                Desc_1.TextTransparency = 0.4
                Desc_1.TextXAlignment = Enum.TextXAlignment.Left

                local function Update()
                    Desc_1.Text = type(Value) == "table" and "( . . . . . . )" or Value
                end

                local Dropdown = Instance.new("Frame")
                local Search_1 = Instance.new("Frame")
                local UICorner_1 = Instance.new("UICorner")
                local TextBox_1 = Instance.new("TextBox")
                local UIStroke_1 = Instance.new("UIStroke")
                local ScrollingFrame_1 = Instance.new("ScrollingFrame")
                local UIListLayout_1 = Instance.new("UIListLayout")
                local UICorner_3 = Instance.new("UICorner")
                local UIStroke_2 = Instance.new("UIStroke")

                Dropdown.Name = "Dropdown"
                Dropdown.Parent = Background_1
                Dropdown.AnchorPoint = Vector2.new(1, 0.5)
                Dropdown.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                Dropdown.BorderSizePixel = 0
                Dropdown.Position = UDim2.new(1, 0, 0.5, 0)
                Dropdown.Size = UDim2.new(0, 240, 0, 374)
                Dropdown.ZIndex = 3
                Dropdown.Visible = false

                UICorner_3.Parent = Dropdown
                UICorner_3.CornerRadius = UDim.new(0, 8)

                UIStroke_2.Parent = Dropdown
                UIStroke_2.Color = Color3.fromRGB(50, 50, 50)
                UIStroke_2.Thickness = 1.5

                Search_1.Name = "Search"
                Search_1.Parent = Dropdown
                Search_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Search_1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                Search_1.BackgroundTransparency = 0.4
                Search_1.BorderSizePixel = 0
                Search_1.Position = UDim2.new(0.5, 0, 0.08, 0)
                Search_1.Size = UDim2.new(0.92, 0, 0, 30)
                Search_1.ZIndex = 3

                UICorner_1.Parent = Search_1
                UICorner_1.CornerRadius = UDim.new(0, 6)

                TextBox_1.Parent = Search_1
                TextBox_1.Active = true
                TextBox_1.AnchorPoint = Vector2.new(0.5, 0.5)
                TextBox_1.BackgroundTransparency = 1
                TextBox_1.BorderSizePixel = 0
                TextBox_1.Position = UDim2.new(0.5, 0, 0.5, 0)
                TextBox_1.Size = UDim2.new(1, 0, 1, 0)
                TextBox_1.ZIndex = 3
                TextBox_1.Font = Enum.Font.GothamMedium
                TextBox_1.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
                TextBox_1.PlaceholderText = "Search"
                TextBox_1.Text = ""
                TextBox_1.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextBox_1.TextSize = 13

                UIStroke_1.Parent = Search_1
                UIStroke_1.Color = Color3.fromRGB(255, 255, 255)
                UIStroke_1.Thickness = 1
                UIStroke_1.Transparency = 0.7

                ScrollingFrame_1.Name = "ScrollingFrame"
                ScrollingFrame_1.Parent = Dropdown
                ScrollingFrame_1.Active = true
                ScrollingFrame_1.BackgroundTransparency = 1
                ScrollingFrame_1.BorderSizePixel = 0
                ScrollingFrame_1.Position = UDim2.new(0.05, 0, 0.13, 0)
                ScrollingFrame_1.Size = UDim2.new(0.9, 0, 0.83, 0)
                ScrollingFrame_1.ZIndex = 3
                ScrollingFrame_1.ScrollBarThickness = 0

                UIListLayout_1.Parent = ScrollingFrame_1
                UIListLayout_1.Padding = UDim.new(0, 8)
                UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder

                local isOpen = false
                UserInputService.InputBegan:Connect(
                    function(A)
                        if
                            A.UserInputType == Enum.UserInputType.MouseButton1 or
                                A.UserInputType == Enum.UserInputType.Touch
                         then
                            local mouse = LocalPlayer:GetMouse()
                            local mx, my = mouse.X, mouse.Y

                            local DBP, DBS = Dropdown.AbsolutePosition, Dropdown.AbsoluteSize
                            local TBP, TBS = TextBox_1.AbsolutePosition, TextBox_1.AbsoluteSize
                            local SBP, SBS = Search_1.AbsolutePosition, Search_1.AbsoluteSize

                            local function inside(pos, size)
                                return mx >= pos.X and mx <= pos.X + size.X and my >= pos.Y and my <= pos.Y + size.Y
                            end

                            if not inside(DBP, DBS) and not inside(TBP, TBS) and not inside(SBP, SBS) then
                                isOpen = false
                                tw(
                                    {
                                        v = Dropdown,
                                        t = 0.3,
                                        s = "Sine",
                                        d = "Out",
                                        g = {Size = UDim2.new(0, 0, 0, 374)}
                                    }
                                ):Play()
                                Dropdown.Visible = false
                            end
                        end
                    end
                )

                ClickDropdown.MouseButton1Click:Connect(
                    function()
                        for _, v in pairs(Background_1:GetChildren()) do
                            if v.Name == "Dropdown" and v.Visible then
                                return
                            end
                        end
                        isOpen = not isOpen
                        if isOpen then
                            Dropdown.Visible = true
                            tw(
                                {
                                    v = Dropdown,
                                    t = 0.3,
                                    s = "Sine",
                                    d = "Out",
                                    g = {Size = UDim2.new(0, 240, 0, 374)}
                                }
                            ):Play()
                        else
                            tw(
                                {
                                    v = Dropdown,
                                    t = 0.3,
                                    s = "Sine",
                                    d = "Out",
                                    g = {Size = UDim2.new(0, 0, 0, 374)}
                                }
                            ):Play()
                            Dropdown.Visible = false
                        end
                        EffectClick(ClickDropdown, Dropdownz)
                        tw(
                            {
                                v = Icon_1,
                                t = 0.15,
                                s = "Bounce",
                                d = "Out",
                                g = {Size = UDim2.new(0, 30, 0, 30)}
                            }
                        ):Play()
                        delay(
                            0.1,
                            function()
                                tw(
                                    {
                                        v = Icon_1,
                                        t = 0.15,
                                        s = "Bounce",
                                        d = "Out",
                                        g = {Size = UDim2.new(0, 24, 0, 24)}
                                    }
                                ):Play()
                            end
                        )
                    end
                )

                TextBox_1.Changed:Connect(
                    function()
                        local SearchT = string.lower(TextBox_1.Text)
                        for _, v in pairs(ScrollingFrame_1:GetChildren()) do
                            if v:IsA("Frame") then
                                local labelText = string.lower(v.Real.Title.Text)
                                if string.find(labelText, SearchT, 1, true) then
                                    v.Visible = true
                                else
                                    v.Visible = false
                                end
                            end
                        end
                    end
                )

                local itemslist = {}
                local selectedItem
                local selectedValues = {}

                function itemslist:Clear(a)
                    local function shouldClear(v)
                        if a == nil then
                            return true
                        elseif type(a) == "string" then
                            return v.Real:FindFirstChild("Title") and v.Real.Title.Text == a
                        elseif type(a) == "table" then
                            for _, name in ipairs(a) do
                                if v.Real:FindFirstChild("Title") and v.Real.Title.Text == name then
                                    return true
                                end
                            end
                        end
                        return false
                    end

                    for _, v in ipairs(ScrollingFrame_1:GetChildren()) do
                        if v:IsA("Frame") and shouldClear(v) then
                            if selectedItem and v.Real:FindFirstChild("Title") and v.Real.Title.Text == selectedItem then
                                selectedItem = nil
                                Desc_1.Text = ""
                            end
                            v:Destroy()
                        end
                    end

                    if selectedItem == a or Desc_1.Text == a then
                        selectedItem = nil
                        Desc_1.Text = ""
                    end

                    if a == nil then
                        selectedItem = nil
                        Desc_1.Text = ""
                    end
                end

                local function isValueInTable(val, tbl)
                    if type(tbl) ~= "table" then
                        return false
                    end
                    for _, v in pairs(tbl) do
                        if v == val then
                            return true
                        end
                    end
                    return false
                end

                function itemslist:AddList(text)
                    local Items_1 = Instance.new("Frame")
                    local ClickList = click(Items_1)
                    local Real_1 = Instance.new("Frame")
                    local Title_1 = Instance.new("TextLabel")
                    local Line_1 = Instance.new("Frame")
                    local UICorner_2 = Instance.new("UICorner")
                    local UIListLayout_2 = Instance.new("UIListLayout")

                    Items_1.Name = "Items"
                    Items_1.Parent = ScrollingFrame_1
                    Items_1.BackgroundTransparency = 1
                    Items_1.BorderSizePixel = 0
                    Items_1.Size = UDim2.new(1, 0, 0, 35)
                    Items_1.ZIndex = 3

                    Real_1.Name = "Real"
                    Real_1.Parent = Items_1
                    Real_1.AnchorPoint = Vector2.new(0.5, 0.5)
                    Real_1.BackgroundTransparency = 1
                    Real_1.BorderSizePixel = 0
                    Real_1.Position = UDim2.new(0.5, 0, 0.5, 0)
                    Real_1.Size = UDim2.new(1, 0, 1, 0)
                    Real_1.ZIndex = 3

                    Title_1.Name = "Title"
                    Title_1.Parent = Real_1
                    Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
                    Title_1.BackgroundTransparency = 1
                    Title_1.BorderSizePixel = 0
                    Title_1.Position = UDim2.new(0.57, 0, 0.5, 0)
                    Title_1.Size = UDim2.new(0.66, 0, 1, 0)
                    Title_1.ZIndex = 3
                    Title_1.Font = Enum.Font.GothamMedium
                    Title_1.Text = text
                    Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Title_1.TextSize = 13
                    Title_1.TextXAlignment = Enum.TextXAlignment.Left
                    Title_1.TextTransparency = 0.4

                    Line_1.Name = "Line"
                    Line_1.Parent = Real_1
                    Line_1.AnchorPoint = Vector2.new(0, 0.5)
                    Line_1.BackgroundColor3 = Color3.fromRGB(100, 140, 255)
                    Line_1.BorderSizePixel = 0
                    Line_1.Position = UDim2.new(0, 0, 0.5, 0)
                    Line_1.Size = UDim2.new(0, 5, 1, 0)
                    Line_1.ZIndex = 3
                    Line_1.BackgroundTransparency = 1

                    UICorner_2.Parent = Line_1
                    UICorner_2.CornerRadius = UDim.new(1, 0)

                    UIListLayout_2.Parent = Real_1
                    UIListLayout_2.Padding = UDim.new(0, 12)
                    UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
                    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
                    UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center

                    ClickList.MouseButton1Click:Connect(
                        function()
                            Update()
                            if Multi then
                                if selectedValues[text] then
                                    selectedValues[text] = nil
                                    tw(
                                        {
                                            v = Title_1,
                                            t = 0.2,
                                            s = "Sine",
                                            d = "Out",
                                            g = {TextTransparency = 0.4}
                                        }
                                    ):Play()
                                    tw(
                                        {
                                            v = Line_1,
                                            t = 0.2,
                                            s = "Sine",
                                            d = "Out",
                                            g = {BackgroundTransparency = 1}
                                        }
                                    ):Play()
                                    tw(
                                        {
                                            v = Items_1,
                                            t = 0.2,
                                            s = "Sine",
                                            d = "Out",
                                            g = {BackgroundTransparency = 1}
                                        }
                                    ):Play()
                                else
                                    selectedValues[text] = true
                                    tw(
                                        {
                                            v = Title_1,
                                            t = 0.2,
                                            s = "Sine",
                                            d = "Out",
                                            g = {TextTransparency = 0}
                                        }
                                    ):Play()
                                    tw(
                                        {
                                            v = Line_1,
                                            t = 0.2,
                                            s = "Sine",
                                            d = "Out",
                                            g = {BackgroundTransparency = 0}
                                        }
                                    ):Play()
                                    tw(
                                        {
                                            v = Items_1,
                                            t = 0.2,
                                            s = "Sine",
                                            d = "Out",
                                            g = {BackgroundTransparency = 0.8}
                                        }
                                    ):Play()
                                end
                                local selectedList = {}
                                for i, v in pairs(selectedValues) do
                                    table.insert(selectedList, i)
                                end
                                if #selectedList > 0 then
                                    Update()
                                else
                                    Desc_1.Text = ""
                                end
                                pcall(Callback, selectedList)
                            else
                                for _, v in pairs(ScrollingFrame_1:GetChildren()) do
                                    if v:IsA("Frame") then
                                        tw(
                                            {
                                                v = v.Real.Title,
                                                t = 0.2,
                                                s = "Sine",
                                                d = "Out",
                                                g = {TextTransparency = 0.4}
                                            }
                                        ):Play()
                                        tw(
                                            {
                                                v = v.Real.Line,
                                                t = 0.2,
                                                s = "Sine",
                                                d = "Out",
                                                g = {BackgroundTransparency = 1}
                                            }
                                        ):Play()
                                        tw(
                                            {
                                                v = v,
                                                t = 0.2,
                                                s = "Sine",
                                                d = "Out",
                                                g = {BackgroundTransparency = 1}
                                            }
                                        ):Play()
                                    end
                                end
                                tw(
                                    {
                                        v = Title_1,
                                        t = 0.2,
                                        s = "Sine",
                                        d = "Out",
                                        g = {TextTransparency = 0}
                                    }
                                ):Play()
                                tw(
                                    {
                                        v = Line_1,
                                        t = 0.2,
                                        s = "Sine",
                                        d = "Out",
                                        g = {BackgroundTransparency = 0}
                                    }
                                ):Play()
                                tw(
                                    {
                                        v = Items_1,
                                        t = 0.2,
                                        s = "Sine",
                                        d = "Out",
                                        g = {BackgroundTransparency = 0.8}
                                    }
                                ):Play()
                                tw(
                                    {
                                        v = Dropdown,
                                        t = 0.3,
                                        s = "Sine",
                                        d = "Out",
                                        g = {Size = UDim2.new(0, 0, 0, 374)}
                                    }
                                ):Play()
                                isOpen = false
                                Value = text
                                Desc_1.Text = text
                                pcall(Callback, Desc_1.Text)
                                task.wait(0.05)
                                Dropdown.Visible = false
                            end
                        end
                    )

                    if Multi then
                        if isValueInTable(text, Value) then
                            tw(
                                {
                                    v = Title_1,
                                    t = 0.2,
                                    s = "Sine",
                                    d = "Out",
                                    g = {TextTransparency = 0}
                                }
                            ):Play()
                            tw(
                                {
                                    v = Line_1,
                                    t = 0.2,
                                    s = "Sine",
                                    d = "Out",
                                    g = {BackgroundTransparency = 0}
                                }
                            ):Play()
                            tw(
                                {
                                    v = Items_1,
                                    t = 0.2,
                                    s = "Sine",
                                    d = "Out",
                                    g = {BackgroundTransparency = 0.8}
                                }
                            ):Play()
                            selectedValues[text] = true
                            local selectedList = {}
                            for i, v in pairs(selectedValues) do
                                table.insert(selectedList, i)
                            end
                            if #selectedList > 0 then
                                Update()
                            else
                                Desc_1.Text = ""
                            end
                            pcall(Callback, selectedList)
                        end
                    else
                        if text == Value then
                            tw(
                                {
                                    v = Title_1,
                                    t = 0.2,
                                    s = "Sine",
                                    d = "Out",
                                    g = {TextTransparency = 0}
                                }
                            ):Play()
                            tw(
                                {
                                    v = Line_1,
                                    t = 0.2,
                                    s = "Sine",
                                    d = "Out",
                                    g = {BackgroundTransparency = 0}
                                }
                            ):Play()
                            tw(
                                {
                                    v = Items_1,
                                    t = 0.2,
                                    s = "Sine",
                                    d = "Out",
                                    g = {BackgroundTransparency = 0.8}
                                }
                            ):Play()
                            Value = text
                            Desc_1.Text = text
                            Callback(Desc_1.Text)
                        end
                    end
                end

                for _, name in ipairs(List) do
                    itemslist:AddList(name)
                end

                UIListLayout_1:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                    function()
                        ScrollingFrame_1.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_1.AbsoluteContentSize.Y + 8)
                    end
                )

                return itemslist
            end

            function Env.Class:Slider(info)
                local Title = info.Title
                local Min = info.Min or 0
                local Max = info.Max or 100
                local Rounding = info.Rounding or 0
                local Value = info.Value or Min
                local Callback = info.CallBack or function()
                    end

                local Slider = Instance.new("Frame")
                local UICorner_1 = Instance.new("UICorner")
                local Title_1 = Instance.new("TextLabel")
                local Novalue_1 = Instance.new("Frame")
                local UICorner_2 = Instance.new("UICorner")
                local Color_1 = Instance.new("Frame")
                local UICorner_3 = Instance.new("UICorner")
                local UIGradient_1 = Instance.new("UIGradient")
                local textvalue_1 = Instance.new("TextBox")
                local Slide = click(Slider)

                Slider.Name = "Slider"
                Slider.Parent = Section_1
                Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Slider.BackgroundTransparency = 0.9
                Slider.BorderSizePixel = 0
                Slider.Size = UDim2.new(0.95, 0, 0, 55)

                UICorner_1.Parent = Slider
                UICorner_1.CornerRadius = UDim.new(0, 6)

                Title_1.Name = "Title"
                Title_1.Parent = Slider
                Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Title_1.BackgroundTransparency = 1
                Title_1.BorderSizePixel = 0
                Title_1.Position = UDim2.new(0.4, 0, 0.3, 0)
                Title_1.Size = UDim2.new(0.7, 0, 0, 12)
                Title_1.Font = Enum.Font.GothamMedium
                Title_1.Text = Title
                Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title_1.TextSize = 12
                Title_1.TextXAlignment = Enum.TextXAlignment.Left

                Novalue_1.Name = "Novalue"
                Novalue_1.Parent = Slider
                Novalue_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Novalue_1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                Novalue_1.BorderSizePixel = 0
                Novalue_1.Position = UDim2.new(0.5, 0, 0.7, 0)
                Novalue_1.Size = UDim2.new(0.92, 0, 0, 18)
                Novalue_1.ClipsDescendants = true

                UICorner_2.Parent = Novalue_1
                UICorner_2.CornerRadius = UDim.new(1, 0)

                Color_1.Name = "Color"
                Color_1.Parent = Novalue_1
                Color_1.AnchorPoint = Vector2.new(0, 0.5)
                Color_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Color_1.BorderSizePixel = 0
                Color_1.Position = UDim2.new(0, 0, 0.5, 0)
                Color_1.Size = UDim2.new(1, 0, 1, 0)

                UICorner_3.Parent = Color_1
                UICorner_3.CornerRadius = UDim.new(1, 0)

                UIGradient_1.Parent = Color_1
                UIGradient_1.Color =
                    ColorSequence.new {
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 140, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 180, 255))
                }

                textvalue_1.Name = "textvalue"
                textvalue_1.Parent = Slider
                textvalue_1.Active = true
                textvalue_1.AnchorPoint = Vector2.new(0.5, 0.5)
                textvalue_1.BackgroundTransparency = 1
                textvalue_1.BorderSizePixel = 0
                textvalue_1.Position = UDim2.new(0.73, 0, 0.3, 0)
                textvalue_1.Size = UDim2.new(0, 90, 0, 12)
                textvalue_1.Font = Enum.Font.GothamMedium
                textvalue_1.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
                textvalue_1.PlaceholderText = "..."
                textvalue_1.Text = tostring(Value)
                textvalue_1.TextColor3 = Color3.fromRGB(255, 255, 255)
                textvalue_1.TextSize = 11
                textvalue_1.TextXAlignment = Enum.TextXAlignment.Right

                local function roundToDecimal(value, decimals)
                    local factor = 10 ^ decimals
                    return math.floor(value * factor + 0.5) / factor
                end

                local function updateSlider(value)
                    value = math.clamp(value, Min, Max)
                    value = roundToDecimal(value, Rounding)
                    tw(
                        {
                            v = Color_1,
                            t = 0.2,
                            s = "Sine",
                            d = "Out",
                            g = {Size = UDim2.new((value - Min) / (Max - Min), 0, 1, 0)}
                        }
                    ):Play()
                    local startValue = tonumber(textvalue_1.Text) or 0
                    local targetValue = value
                    local steps = 5
                    local currentValue = startValue
                    for i = 1, steps do
                        task.wait(0.015 / steps)
                        currentValue = currentValue + (targetValue - startValue) / steps
                        textvalue_1.Text = tostring(roundToDecimal(currentValue, Rounding))
                    end
                    textvalue_1.Text = tostring(roundToDecimal(targetValue, Rounding))
                    Callback(value)
                end

                updateSlider(Value or 0)

                local function move(input)
                    local sliderBar = Novalue_1
                    local relativeX =
                        math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
                    local value = relativeX * (Max - Min) + Min
                    updateSlider(value)
                end

                textvalue_1.FocusLost:Connect(
                    function()
                        local value = tonumber(textvalue_1.Text) or Min
                        updateSlider(value)
                    end
                )

                local dragging = false

                Slide.InputBegan:Connect(
                    function(input)
                        for _, v in pairs(Background_1:GetChildren()) do
                            if v.Name == "Dropdown" and v.Visible then
                                return
                            end
                        end
                        if
                            input.UserInputType == Enum.UserInputType.MouseButton1 or
                                input.UserInputType == Enum.UserInputType.Touch
                         then
                            dragging = true
                            move(input)
                        end
                    end
                )

                Slide.InputEnded:Connect(
                    function(input)
                        for _, v in pairs(Background_1:GetChildren()) do
                            if v.Name == "Dropdown" and v.Visible then
                                return
                            end
                        end
                        if
                            input.UserInputType == Enum.UserInputType.MouseButton1 or
                                input.UserInputType == Enum.UserInputType.Touch
                         then
                            dragging = false
                        end
                    end
                )

                UserInputService.InputChanged:Connect(
                    function(input)
                        for _, v in pairs(Background_1:GetChildren()) do
                            if v.Name == "Dropdown" and v.Visible then
                                return
                            end
                        end
                        if
                            dragging and
                                (input.UserInputType == Enum.UserInputType.MouseMovement or
                                    input.UserInputType == Enum.UserInputType.Touch)
                         then
                            move(input)
                        end
                    end
                )

                local NewValue = {}
                function NewValue:Value(a)
                    Value = a
                    updateSlider(Value)
                end
                function NewValue:Visible(a)
                    Slider.Visible = a
                end
                function NewValue:Title(b)
                    Title_1.Text = b
                end
                return NewValue
            end

            function Env.Class:Textbox(meta)
                local Value = meta.Value or "Example"
                local ClearOnFocus = meta.ClearOnFocus or false
                local Callback = meta.Callback or function()
                    end

                local Textbox = Instance.new("Frame")
                local UICorner_1 = Instance.new("UICorner")
                local TextBox_1 = Instance.new("TextBox")

                Textbox.Name = "Textbox"
                Textbox.Parent = Section_1
                Textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Textbox.BackgroundTransparency = 0.9
                Textbox.BorderSizePixel = 0
                Textbox.Size = UDim2.new(0.95, 0, 0, 30)

                UICorner_1.Parent = Textbox
                UICorner_1.CornerRadius = UDim.new(0, 6)

                TextBox_1.Parent = Textbox
                TextBox_1.Active = true
                TextBox_1.AnchorPoint = Vector2.new(0.5, 0.5)
                TextBox_1.BackgroundTransparency = 1
                TextBox_1.BorderSizePixel = 0
                TextBox_1.Position = UDim2.new(0.5, 0, 0.5, 0)
                TextBox_1.Size = UDim2.new(1, 0, 1, 0)
                TextBox_1.Font = Enum.Font.GothamMedium
                TextBox_1.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
                TextBox_1.PlaceholderText = "..."
                TextBox_1.Text = Value
                TextBox_1.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextBox_1.TextSize = 12
                TextBox_1.ClearTextOnFocus = ClearOnFocus

                TextBox_1.FocusLost:Connect(
                    function()
                        Value = TextBox_1.Text
                        Callback(Value)
                    end
                )

                local i = {}
                function i:Value(v)
                    Value = v
                    TextBox_1.Text = v
                    Callback(v)
                end
                function i:Visible(v)
                    Textbox.Visible = v
                end
                return i
            end

            function Env.Class:Keybind(meta)
                local Title = meta.Title or "Keybind"
                local Value = meta.Value or Enum.KeyCode.Unknown
                local Callback = meta.Callback or function()
                    end

                local Keybind = Instance.new("Frame")
                local UICorner_1 = Instance.new("UICorner")
                local Title_1 = Instance.new("TextLabel")
                local Key_1 = Instance.new("TextButton")
                local UICorner_2 = Instance.new("UICorner")

                Keybind.Name = "Keybind"
                Keybind.Parent = Section_1
                Keybind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Keybind.BackgroundTransparency = 0.9
                Keybind.BorderSizePixel = 0
                Keybind.Size = UDim2.new(0.95, 0, 0, 30)

                UICorner_1.Parent = Keybind
                UICorner_1.CornerRadius = UDim.new(0, 6)

                Title_1.Name = "Title"
                Title_1.Parent = Keybind
                Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Title_1.BackgroundTransparency = 1
                Title_1.BorderSizePixel = 0
                Title_1.Position = UDim2.new(0.4, 0, 0.5, 0)
                Title_1.Size = UDim2.new(0.7, 0, 0, 12)
                Title_1.Font = Enum.Font.GothamMedium
                Title_1.Text = Title
                Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title_1.TextSize = 12
                Title_1.TextXAlignment = Enum.TextXAlignment.Left

                Key_1.Name = "Key"
                Key_1.Parent = Keybind
                Key_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Key_1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                Key_1.BorderSizePixel = 0
                Key_1.Position = UDim2.new(0.9, 0, 0.5, 0)
                Key_1.Size = UDim2.new(0, 50, 0, 20)
                Key_1.Font = Enum.Font.GothamMedium
                Key_1.Text = Value.Name
                Key_1.TextColor3 = Color3.fromRGB(255, 255, 255)
                Key_1.TextSize = 12

                UICorner_2.Parent = Key_1
                UICorner_2.CornerRadius = UDim.new(0, 4)

                local binding = false
                Key_1.MouseButton1Click:Connect(
                    function()
                        for _, v in pairs(Background_1:GetChildren()) do
                            if v.Name == "Dropdown" and v.Visible then
                                return
                            end
                        end
                        binding = true
                        Key_1.Text = "..."
                    end
                )

                UserInputService.InputBegan:Connect(
                    function(input)
                        if binding and input.UserInputType == Enum.UserInputType.Keyboard then
                            Value = input.KeyCode
                            Key_1.Text = Value.Name
                            binding = false
                            Callback(Value)
                        end
                    end
                )

                local i = {}
                function i:Value(v)
                    Value = v
                    Key_1.Text = v.Name
                    Callback(v)
                end
                function i:Visible(v)
                    Keybind.Visible = v
                end
                return i
            end

            function Env.Class:Label(meta)
                local Title = meta.Title or "Label"

                local Label = Instance.new("Frame")
                local UICorner_1 = Instance.new("UICorner")
                local Title_1 = Instance.new("TextLabel")

                Label.Name = "Label"
                Label.Parent = Section_1
                Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Label.BackgroundTransparency = 0.9
                Label.BorderSizePixel = 0
                Label.Size = UDim2.new(0.95, 0, 0, 30)

                UICorner_1.Parent = Label
                UICorner_1.CornerRadius = UDim.new(0, 6)

                Title_1.Name = "Title"
                Title_1.Parent = Label
                Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Title_1.BackgroundTransparency = 1
                Title_1.BorderSizePixel = 0
                Title_1.Position = UDim2.new(0.5, 0, 0.5, 0)
                Title_1.Size = UDim2.new(1, 0, 0, 12)
                Title_1.Font = Enum.Font.GothamMedium
                Title_1.Text = Title
                Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title_1.TextSize = 12

                local i = {}
                function i:Text(v)
                    Title_1.Text = v
                end
                function i:Visible(v)
                    Label.Visible = v
                end
                return i
            end

            function Env.Class:ColorPicker(meta)
                local Title = meta.Title or "ColorPicker"
                local Value = meta.Value or Color3.fromRGB(255, 255, 255)
                local Callback = meta.Callback or function()
                    end

                local ColorPicker = Instance.new("Frame")
                local UICorner_1 = Instance.new("UICorner")
                local Title_1 = Instance.new("TextLabel")
                local Color_1 = Instance.new("Frame")
                local UICorner_2 = Instance.new("UICorner")
                local Click = click(ColorPicker)

                ColorPicker.Name = "ColorPicker"
                ColorPicker.Parent = Section_1
                ColorPicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorPicker.BackgroundTransparency = 0.9
                ColorPicker.BorderSizePixel = 0
                ColorPicker.Size = UDim2.new(0.95, 0, 0, 30)

                UICorner_1.Parent = ColorPicker
                UICorner_1.CornerRadius = UDim.new(0, 6)

                Title_1.Name = "Title"
                Title_1.Parent = ColorPicker
                Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Title_1.BackgroundTransparency = 1
                Title_1.BorderSizePixel = 0
                Title_1.Position = UDim2.new(0.4, 0, 0.5, 0)
                Title_1.Size = UDim2.new(0.7, 0, 0, 12)
                Title_1.Font = Enum.Font.GothamMedium
                Title_1.Text = Title
                Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title_1.TextSize = 12
                Title_1.TextXAlignment = Enum.TextXAlignment.Left

                Color_1.Name = "Color"
                Color_1.Parent = ColorPicker
                Color_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Color_1.BackgroundColor3 = Value
                Color_1.BorderSizePixel = 0
                Color_1.Position = UDim2.new(0.9, 0, 0.5, 0)
                Color_1.Size = UDim2.new(0, 28, 0, 28)

                UICorner_2.Parent = Color_1
                UICorner_2.CornerRadius = UDim.new(1, 0)

                local Picker = Instance.new("Frame")
                local UICorner_3 = Instance.new("UICorner")
                local UIStroke_1 = Instance.new("UIStroke")
                local Saturation = Instance.new("ImageLabel")
                local SaturationClick = click(Saturation)
                local Hue = Instance.new("ImageLabel")
                local HueClick = click(Hue)
                local Alpha = Instance.new("ImageLabel")
                local AlphaClick = click(Alpha)

                Picker.Name = "Picker"
                Picker.Parent = Background_1
                Picker.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                Picker.BorderSizePixel = 0
                Picker.Position = UDim2.new(1, 0, 0.5, 0)
                Picker.Size = UDim2.new(0, 240, 0, 200)
                Picker.ZIndex = 3
                Picker.Visible = false

                UICorner_3.Parent = Picker
                UICorner_3.CornerRadius = UDim.new(0, 8)

                UIStroke_1.Parent = Picker
                UIStroke_1.Color = Color3.fromRGB(50, 50, 50)
                UIStroke_1.Thickness = 1.5

                Saturation.Name = "Saturation"
                Saturation.Parent = Picker
                Saturation.BackgroundTransparency = 1
                Saturation.Position = UDim2.new(0.05, 0, 0.1, 0)
                Saturation.Size = UDim2.new(0.65, 0, 0.85, 0)
                Saturation.ZIndex = 3
                Saturation.Image = "rbxassetid://698052001"
                Saturation.ImageColor3 = Value

                Hue.Name = "Hue"
                Hue.Parent = Picker
                Hue.BackgroundTransparency = 1
                Hue.Position = UDim2.new(0.75, 0, 0.1, 0)
                Hue.Size = UDim2.new(0.1, 0, 0.85, 0)
                Hue.ZIndex = 3
                Hue.Image = "rbxassetid://698052001"

                Alpha.Name = "Alpha"
                Alpha.Parent = Picker
                Alpha.BackgroundTransparency = 1
                Alpha.Position = UDim2.new(0.87, 0, 0.1, 0)
                Alpha.Size = UDim2.new(0.1, 0, 0.85, 0)
                Alpha.ZIndex = 3
                Alpha.Image = "rbxassetid://698052001"

                local h, s, v = Value:ToHSV()
                local function updateColor()
                    local color = Color3.fromHSV(h, s, v)
                    Color_1.BackgroundColor3 = color
                    Saturation.ImageColor3 = Color3.fromHSV(h, 1, 1)
                    Callback(color)
                end

                local function updateSaturation(input)
                    local relativeX =
                        math.clamp((input.Position.X - Saturation.AbsolutePosition.X) / Saturation.AbsoluteSize.X, 0, 1)
                    local relativeY =
                        math.clamp((input.Position.Y - Saturation.AbsolutePosition.Y) / Saturation.AbsoluteSize.Y, 0, 1)
                    s = relativeX
                    v = 1 - relativeY
                    updateColor()
                end

                local function updateHue(input)
                    local relativeY = math.clamp((input.Position.Y - Hue.AbsolutePosition.Y) / Hue.AbsoluteSize.Y, 0, 1)
                    h = 1 - relativeY
                    updateColor()
                end

                local function updateAlpha(input)
                    local relativeY =
                        math.clamp((input.Position.Y - Alpha.AbsolutePosition.Y) / Alpha.AbsoluteSize.Y, 0, 1)
                    v = 1 - relativeY
                    updateColor()
                end

                local draggingSaturation, draggingHue, draggingAlpha = false, false, false

                SaturationClick.InputBegan:Connect(
                    function(input)
                        if
                            input.UserInputType == Enum.UserInputType.MouseButton1 or
                                input.UserInputType == Enum.UserInputType.Touch
                         then
                            draggingSaturation = true
                            updateSaturation(input)
                        end
                    end
                )

                SaturationClick.InputEnded:Connect(
                    function(input)
                        if
                            input.UserInputType == Enum.UserInputType.MouseButton1 or
                                input.UserInputType == Enum.UserInputType.Touch
                         then
                            draggingSaturation = false
                        end
                    end
                )

                HueClick.InputBegan:Connect(
                    function(input)
                        if
                            input.UserInputType == Enum.UserInputType.MouseButton1 or
                                input.UserInputType == Enum.UserInputType.Touch
                         then
                            draggingHue = true
                            updateHue(input)
                        end
                    end
                )

                HueClick.InputEnded:Connect(
                    function(input)
                        if
                            input.UserInputType == Enum.UserInputType.MouseButton1 or
                                input.UserInputType == Enum.UserInputType.Touch
                         then
                            draggingHue = false
                        end
                    end
                )

                AlphaClick.InputBegan:Connect(
                    function(input)
                        if
                            input.UserInputType == Enum.UserInputType.MouseButton1 or
                                input.UserInputType == Enum.UserInputType.Touch
                         then
                            draggingAlpha = true
                            updateAlpha(input)
                        end
                    end
                )

                AlphaClick.InputEnded:Connect(
                    function(input)
                        if
                            input.UserInputType == Enum.UserInputType.MouseButton1 or
                                input.UserInputType == Enum.UserInputType.Touch
                         then
                            draggingAlpha = false
                        end
                    end
                )

                UserInputService.InputChanged:Connect(
                    function(input)
                        if
                            input.UserInputType == Enum.UserInputType.MouseMovement or
                                input.UserInputType == Enum.UserInputType.Touch
                         then
                            if draggingSaturation then
                                updateSaturation(input)
                            end
                            if draggingHue then
                                updateHue(input)
                            end
                            if draggingAlpha then
                                updateAlpha(input)
                            end
                        end
                    end
                )

                local isOpen = false
                Click.MouseButton1Click:Connect(
                    function()
                        for _, v in pairs(Background_1:GetChildren()) do
                            if v.Name == "Dropdown" and v.Visible then
                                return
                            end
                        end
                        isOpen = not isOpen
                        Picker.Visible = isOpen
                        tw(
                            {
                                v = Picker,
                                t = 0.3,
                                s = "Sine",
                                d = "Out",
                                g = {Size = isOpen and UDim2.new(0, 240, 0, 200) or UDim2.new(0, 0, 0, 200)}
                            }
                        ):Play()
                        EffectClick(Click, ColorPicker)
                    end
                )

                UserInputService.InputBegan:Connect(
                    function(input)
                        if
                            input.UserInputType == Enum.UserInputType.MouseButton1 or
                                input.UserInputType == Enum.UserInputType.Touch
                         then
                            local mouse = LocalPlayer:GetMouse()
                            local mx, my = mouse.X, mouse.Y
                            local pos, size = Picker.AbsolutePosition, Picker.AbsoluteSize
                            if not (mx >= pos.X and mx <= pos.X + size.X and my >= pos.Y and my <= pos.Y + size.Y) then
                                isOpen = false
                                Picker.Visible = false
                                tw(
                                    {
                                        v = Picker,
                                        t = 0.3,
                                        s = "Sine",
                                        d = "Out",
                                        g = {Size = UDim2.new(0, 0, 0, 200)}
                                    }
                                ):Play()
                            end
                        end
                    end
                )

                local i = {}
                function i:Value(v)
                    Value = v
                    h, s, v = Value:ToHSV()
                    updateColor()
                end
                function i:Visible(v)
                    ColorPicker.Visible = v
                end
                return i
            end

            function Env.Class:Discord(meta)
                local InviteCode = meta.Invite or ""
                local DefaultIcon = meta.DefaultIcon or "rbxassetid://0"
                local DefaultBanner = meta.DefaultBanner or "rbxassetid://0"

                if InviteCode == "" then
                    warn("Discord invite code is required")
                    return {}
                end

                local DiscordFrame = Instance.new("Frame")
                local UICorner_1 = Instance.new("UICorner")
                local UIGradient_1 = Instance.new("UIGradient")
                local Icon_1 = Instance.new("ImageLabel")
                local UICorner_2 = Instance.new("UICorner")
                local Name_1 = Instance.new("TextLabel")
                local Members_1 = Instance.new("TextLabel")
                local Banner_1 = Instance.new("ImageLabel")
                local UICorner_3 = Instance.new("UICorner")
                local JoinButton = Instance.new("TextButton")
                local UICorner_4 = Instance.new("UICorner")
                local UIGradient_2 = Instance.new("UIGradient")
                local Click = click(DiscordFrame)

                DiscordFrame.Name = "Discord"
                DiscordFrame.Parent = Section_1
                DiscordFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DiscordFrame.BackgroundTransparency = 0.9
                DiscordFrame.BorderSizePixel = 0
                DiscordFrame.Size = UDim2.new(0.95, 0, 0, 120)
                DiscordFrame.ClipsDescendants = true

                UICorner_1.Parent = DiscordFrame
                UICorner_1.CornerRadius = UDim.new(0, 6)

                UIGradient_1.Parent = DiscordFrame
                UIGradient_1.Color =
                    ColorSequence.new {
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(54, 57, 65)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 43, 50))
                }
                UIGradient_1.Rotation = 90

                Icon_1.Name = "Icon"
                Icon_1.Parent = DiscordFrame
                Icon_1.AnchorPoint = Vector2.new(0.5, 0.5)
                Icon_1.BackgroundTransparency = 1
                Icon_1.BorderSizePixel = 0
                Icon_1.Position = UDim2.new(0.08, 0, 0.5, 0)
                Icon_1.Size = UDim2.new(0, 50, 0, 50)

                UICorner_2.Parent = Icon_1
                UICorner_2.CornerRadius = UDim.new(1, 0)

                Name_1.Name = "Name"
                Name_1.Parent = DiscordFrame
                Name_1.BackgroundTransparency = 1
                Name_1.BorderSizePixel = 0
                Name_1.Position = UDim2.new(0.2, 0, 0.2, 0)
                Name_1.Size = UDim2.new(0.6, 0, 0, 20)
                Name_1.Font = Enum.Font.GothamBold
                Name_1.Text = "Loading..."
                Name_1.TextColor3 = Color3.fromRGB(255, 255, 255)
                Name_1.TextSize = 14
                Name_1.TextXAlignment = Enum.TextXAlignment.Left

                Members_1.Name = "Members"
                Members_1.Parent = DiscordFrame
                Members_1.BackgroundTransparency = 1
                Members_1.BorderSizePixel = 0
                Members_1.Position = UDim2.new(0.2, 0, 0.5, 0)
                Members_1.Size = UDim2.new(0.6, 0, 0, 16)
                Members_1.Font = Enum.Font.GothamMedium
                Members_1.Text = "Loading..."
                Members_1.TextColor3 = Color3.fromRGB(180, 180, 180)
                Members_1.TextSize = 12
                Members_1.TextXAlignment = Enum.TextXAlignment.Left

                Banner_1.Name = "Banner"
                Banner_1.Parent = DiscordFrame
                Banner_1.BackgroundColor3 = Color3.fromRGB(40, 43, 50)
                Banner_1.BorderSizePixel = 0
                Banner_1.Position = UDim2.new(0, 0, 0, 0)
                Banner_1.Size = UDim2.new(1, 0, 0.3, 0)
                Banner_1.ImageTransparency = 0.2
                Banner_1.ScaleType = Enum.ScaleType.Crop

                UICorner_3.Parent = Banner_1
                UICorner_3.CornerRadius = UDim.new(0, 6, 0, 0)

                JoinButton.Name = "Join"
                JoinButton.Parent = DiscordFrame
                JoinButton.BackgroundColor3 = Color3.fromRGB(116, 127, 255)
                JoinButton.BorderSizePixel = 0
                JoinButton.Position = UDim2.new(0.7, 0, 0.7, 0)
                JoinButton.Size = UDim2.new(0, 80, 0, 25)
                JoinButton.Font = Enum.Font.GothamBold
                JoinButton.Text = "Join Now"
                JoinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                JoinButton.TextSize = 12

                UICorner_4.Parent = JoinButton
                UICorner_4.CornerRadius = UDim.new(0, 6)

                UIGradient_2.Parent = JoinButton
                UIGradient_2.Color =
                    ColorSequence.new {
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(116, 127, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(88, 101, 242))
                }
                UIGradient_2.Rotation = -135

                local success, data =
                    pcall(
                    function()
                        return HttpService:GetAsync(
                            "https://discord.com/api/v10/invites/" .. InviteCode .. "?with_counts=true"
                        )
                    end
                )

                if success then
                    local decoded = HttpService:JSONDecode(data)
                    if decoded.guild then
                        local guild = decoded.guild
                        Name_1.Text = guild.name or "Unknown Server"
                        Icon_1.Image =
                            guild.icon and
                            ("https://cdn.discordapp.com/icons/" .. guild.id .. "/" .. guild.icon .. ".png") or
                            DefaultIcon
                        Banner_1.Image =
                            guild.banner and
                            ("https://cdn.discordapp.com/banners/" .. guild.id .. "/" .. guild.banner .. ".png") or
                            DefaultBanner
                        local online = decoded.approximate_presence_count or 0
                        local total = decoded.approximate_member_count or 0
                        Members_1.Text = online .. " online / " .. total .. " members"
                    else
                        Name_1.Text = "Invalid Invite"
                        Members_1.Text = "Invalid Invite"
                    end
                else
                    Name_1.Text = "Failed to load"
                    Members_1.Text = "Failed to load"
                end

                JoinButton.MouseButton1Click:Connect(
                    function()
                        setclipboard("https://discord.gg/" .. InviteCode)
                        EffectClick(JoinButton, DiscordFrame)
                    end
                )

                Click.MouseButton1Click:Connect(
                    function()
                        EffectClick(Click, DiscordFrame)
                    end
                )

                local i = {}
                function i:Update(invite)
                    InviteCode = invite
                    local success, data =
                        pcall(
                        function()
                            return HttpService:GetAsync(
                                "https://discord.com/api/v10/invites/" .. invite .. "?with_counts=true"
                            )
                        end
                    )
                    if success then
                        local decoded = HttpService:JSONDecode(data)
                        if decoded.guild then
                            local guild = decoded.guild
                            Name_1.Text = guild.name or "Unknown Server"
                            Icon_1.Image =
                                guild.icon and
                                ("https://cdn.discordapp.com/icons/" .. guild.id .. "/" .. guild.icon .. ".png") or
                                DefaultIcon
                            Banner_1.Image =
                                guild.banner and
                                ("https://cdn.discordapp.com/banners/" .. guild.id .. "/" .. guild.banner .. ".png") or
                                DefaultBanner
                            local online = decoded.approximate_presence_count or 0
                            local total = decoded.approximate_member_count or 0
                            Members_1.Text = online .. " online / " .. total .. " members"
                        end
                    end
                end
                function i:Visible(v)
                    DiscordFrame.Visible = v
                end
                return i
            end

            return Env.Class
        end

        function Env:Notify(meta)
            local Title = meta.Title or "Notification"
            local Desc = meta.Desc or "Description"
            local Time = meta.Time or 3

            local Notification = Instance.new("Frame")
            local UICorner_1 = Instance.new("UICorner")
            local Title_1 = Instance.new("TextLabel")
            local Desc_1 = Instance.new("TextLabel")
            local Line_1 = Instance.new("Frame")
            local Close = Instance.new("TextButton")
            local UICorner_2 = Instance.new("UICorner")

            Notification.Name = "Notification"
            Notification.Parent = Unique
            Notification.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            Notification.BackgroundTransparency = 0.2
            Notification.BorderSizePixel = 0
            Notification.Position = UDim2.new(1, -10, 0.1, 0)
            Notification.Size = UDim2.new(0, 250, 0, 100)
            Notification.ZIndex = 10

            UICorner_1.Parent = Notification
            UICorner_1.CornerRadius = UDim.new(0, 8)

            Title_1.Name = "Title"
            Title_1.Parent = Notification
            Title_1.BackgroundTransparency = 1
            Title_1.Position = UDim2.new(0, 10, 0, 10)
            Title_1.Size = UDim2.new(0.9, 0, 0, 20)
            Title_1.ZIndex = 10
            Title_1.Font = Enum.Font.GothamBold
            Title_1.Text = Title
            Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title_1.TextSize = 14
            Title_1.TextXAlignment = Enum.TextXAlignment.Left

            Desc_1.Name = "Desc"
            Desc_1.Parent = Notification
            Desc_1.BackgroundTransparency = 1
            Desc_1.Position = UDim2.new(0, 10, 0, 35)
            Desc_1.Size = UDim2.new(0.9, 0, 0, 50)
            Desc_1.ZIndex = 10
            Desc_1.Font = Enum.Font.GothamMedium
            Desc_1.Text = Desc
            Desc_1.TextColor3 = Color3.fromRGB(200, 200, 200)
            Desc_1.TextSize = 12
            Desc_1.TextXAlignment = Enum.TextXAlignment.Left
            Desc_1.TextWrapped = true

            Line_1.Name = "Line"
            Line_1.Parent = Notification
            Line_1.BackgroundColor3 = Color3.fromRGB(100, 140, 255)
            Line_1.BorderSizePixel = 0
            Line_1.Position = UDim2.new(0, 0, 1, -5)
            Line_1.Size = UDim2.new(1, 0, 0, 5)
            Line_1.ZIndex = 10

            Close.Name = "Close"
            Close.Parent = Notification
            Close.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            Close.BorderSizePixel = 0
            Close.Position = UDim2.new(1, -25, 0, 5)
            Close.Size = UDim2.new(0, 20, 0, 20)
            Close.ZIndex = 10
            Close.Font = Enum.Font.GothamBold
            Close.Text = "X"
            Close.TextColor3 = Color3.fromRGB(255, 255, 255)
            Close.TextSize = 12

            UICorner_2.Parent = Close
            UICorner_2.CornerRadius = UDim.new(0, 4)

            tw(
                {
                    v = Notification,
                    t = 0.3,
                    s = "Sine",
                    d = "Out",
                    g = {Position = UDim2.new(1, -270, 0.1, 0)}
                }
            ):Play()

            Close.MouseButton1Click:Connect(
                function()
                    tw(
                        {
                            v = Notification,
                            t = 0.3,
                            s = "Sine",
                            d = "Out",
                            g = {Position = UDim2.new(1, -10, 0.1, 0)}
                        }
                    ):Play()
                    task.wait(0.3)
                    Notification:Destroy()
                end
            )

            task.spawn(
                function()
                    task.wait(Time)
                    if Notification.Parent then
                        tw(
                            {
                                v = Notification,
                                t = 0.3,
                                s = "Sine",
                                d = "Out",
                                g = {Position = UDim2.new(1, -10, 0.1, 0)}
                            }
                        ):Play()
                        task.wait(0.3)
                        Notification:Destroy()
                    end
                end
            )
        end
    end
end
return Env
