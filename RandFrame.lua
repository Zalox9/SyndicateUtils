Config = {}

test = CreateFrame("Frame","test", UIParent)
test:RegisterEvent("GET_ITEM_INFO_RECEIVED")
test:SetScript("OnEvent", function(self, event, ...)
    local name, _, _, _, _, _, _, _, _, texture = GetItemInfo(49623)
    print(...)
end);


function Config:ConvertToOne(number)
    if(number == 0) then
        return number
    end
    return number/255
end

function Config:ReturnColorQuality(itemQuality)
    local resultat = nil;
    if(itemQuality == 5) then
        resultat = {
            r=Config:ConvertToOne(255),
            g=Config:ConvertToOne(128),
            b=0,
            a=1
        }
    elseif(itemQuality == 4) then
         resultat = {
            r=Config:ConvertToOne(163),
            g=Config:ConvertToOne(53),
            b=Config:ConvertToOne(238),
            a=1
        }
    elseif(itemQuality == 3) then
        resultat = {
        r=0,
        g=Config:ConvertToOne(112),
        b=Config:ConvertToOne(221),
        a=1
    }
    elseif(itemQuality == 2) then
        resultat = {
        r=Config:ConvertToOne(30),
        g=Config:ConvertToOne(255),
        b=0,
        a=1
    }
    elseif(itemQuality == 1) then
        resultat = {
        r=1,
        g=1,
        b=1,
        a=1
    }
    else
        resultat = {
        r=Config:ConvertToOne(157),
        g=Config:ConvertToOne(157),
        b=Config:ConvertToOne(157),
        a=1
    }
    end
    return resultat;
end

function Config:CreateMenu(idIcone, itemName, iLink, itemQuality)
    local largeur = 200
    UIConfig = CreateFrame("Frame","MUI_BuffFrame",UIParent,"BasicFrameTemplate");
    UIConfig:SetSize(largeur, 125);
    UIConfig:SetPoint("CENTER", UIParent, "CENTER", 0, 350); 

    --- CHILD FRAMES AND REGIONS:
    UIConfig.title = UIConfig:CreateFontString(nil,"OVERLAY");
    UIConfig.title:SetFontObject("GameFontHighlight");
    UIConfig.title:SetPoint("CENTER", UIConfig.TitleBg, "CENTER", 0, 0);
    UIConfig.title:SetText("RAND");


    ------------------
    -- PROGRESS BAR --
    ------------------
    -- parent frame to give the statusbar a background
    UIConfig.progress = CreateFrame("Frame", nil, UIConfig,"TooltipBackdropTemplate")
    UIConfig.progress:SetBackdropBorderColor(0.5,0.5,0.5)
    UIConfig.progress:SetSize(largeur-5,20)
    UIConfig.progress:SetPoint("CENTER", UIConfig, "TOP", 0, -32);

    -- actual status bar, child of parent above
    UIConfig.progress.bar = CreateFrame("StatusBar",nil,UIConfig.progress)
    UIConfig.progress.bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    UIConfig.progress.bar:SetStatusBarColor(0,1,0)
    UIConfig.progress.bar:SetPoint("TOPLEFT",5,-5)
    UIConfig.progress.bar:SetPoint("BOTTOMRIGHT",-5,5)

    -- copying mixins to statusbar
    Mixin(UIConfig.progress.bar,SmoothStatusBarMixin)

    -- using mixin methods
    UIConfig.progress.bar:SetMinMaxSmoothedValue(0,100)
    UIConfig.progress.timer = 15 
    UIConfig.progress.timerRemaining = 100
    UIConfig.progress.smoothTimer = 10
    UIConfig.progress.tick = 100 / UIConfig.progress.timer / UIConfig.progress.smoothTimer


    -- ticker to change value every second
    C_Timer.NewTicker(1 / UIConfig.progress.smoothTimer,function()
        UIConfig.progress.timerRemaining = UIConfig.progress.timerRemaining - UIConfig.progress.tick
    UIConfig.progress.bar:SetSmoothedValue(UIConfig.progress.timerRemaining)
    end)

    -------------
    -- OBJET   --
    -------------
    UIConfig.objet = CreateFrame("Button", nil, UIConfig);
    UIConfig.objet:SetPoint("TOP", UIConfig.progress, "TOP", -60, -40);
    UIConfig.objet:SetSize(64,64);
    UIConfig.objet:SetNormalFontObject("GameFontNormalLarge");
    UIConfig.objet:SetHighlightFontObject("GameFontHighlightLarge")
    local image = UIConfig.objet:CreateTexture(nil, "BACKGROUND")
	image:SetWidth(64)
	image:SetHeight(64)
	image:SetPoint("TOP", 0, 10)
    image:SetTexture(idIcone)

    -------------
    -- NOM     --
    -------------
    --UIConfig.nom = CreateFrame("Frame",nil,UIParent)
    --UIConfig.nom:SetWidth(1) 
    --UIConfig.nom:SetHeight(1) 
    --UIConfig.nom:SetPoint("CENTER",UIConfig.objet, "TOP", 50, -70)
    --UIConfig.nom.text = UIConfig:CreateFontString(nil,"ARTWORK") 
    --UIConfig.nom.text:SetFont("Fonts\\ARIALN.ttf", 13, "THICK")
    --UIConfig.nom.text:SetPoint("CENTER",0,0)
    --UIConfig.nom.text:SetText(itemName)
    --local color = Config:ReturnColorQuality(itemQuality)
    --UIConfig.nom.text:SetTextColor(color.r,color.g,color.b,color.a)
    -------------
    -- BTN BIS --
    -------------
    UIConfig.btnbis = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
    UIConfig.btnbis:SetPoint("TOP", UIConfig.objet, "RIGHT", 30, 44);
    UIConfig.btnbis:SetSize(40,30);
    UIConfig.btnbis:SetText("BIS")
    UIConfig.btnbis:SetNormalFontObject("GameFontNormalLarge");
    UIConfig.btnbis:SetHighlightFontObject("GameFontHighlightLarge")

    -------------
    -- BTN +1 --
    -------------
    UIConfig.btn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
    UIConfig.btn:SetPoint("CENTER", UIConfig.btnbis, "RIGHT", 25, 0);
    UIConfig.btn:SetSize(40,30);
    UIConfig.btn:SetText("+1")
    UIConfig.btn:SetNormalFontObject("GameFontNormalLarge");
    UIConfig.btn:SetHighlightFontObject("GameFontHighlightLarge")

    -------------
    -- BTN +2 --
    -------------
    UIConfig.btn2 = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
    UIConfig.btn2:SetPoint("CENTER", UIConfig.btnbis, "BOTTOM", 0, -20);
    UIConfig.btn2:SetSize(40,30);
    UIConfig.btn2:SetText("+2")
    UIConfig.btn2:SetNormalFontObject("GameFontNormalLarge");
    UIConfig.btn2:SetHighlightFontObject("GameFontHighlightLarge")

    --------------
    -- BTN PASS --
    --------------
    UIConfig.btnPass = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
    UIConfig.btnPass:SetPoint("CENTER", UIConfig.btn2, "RIGHT", 35, 0);
    UIConfig.btnPass:SetSize(60,30);
    UIConfig.btnPass:SetText("PASS")
    UIConfig.btnPass:SetNormalFontObject("GameFontNormalLarge");
    UIConfig.btnPass:SetHighlightFontObject("GameFontHighlightLarge")




    -------------

    --UIConfig:Hide()

    UIConfig.objet:SetScript("OnEnter", function(widget)
        GameTooltip:SetOwner(UIConfig.objet)
        GameTooltip:SetPoint("TOPRIGHT", UIConfig.objet, "TOPRIGHT", 220, -13);
        GameTooltip:SetHyperlink(iLink)
    end)
    UIConfig.objet:SetScript("OnLeave", function(widget)
        GameTooltip:Hide()
    end)
end

testval = Item:CreateFromItemID(50326)
testval:ContinueOnItemLoad(function()
    local idIcone = testval:GetItemIcon()
    local itemName = testval:GetItemName()
    local iLink = testval:GetItemLink()
    local itemQuality = testval:GetItemQuality()
    Config:CreateMenu(idIcone, itemName, iLink, itemQuality)
end)
--Config:CreateMenu(49263)

function UIConfig:Toggle()
    if(UIConfig:IsShown()) then
        UIConfig:Hide()
        --UIConfig.nom:Hide()
    else
        UIConfig:Show()
        --UIConfig.nom:Show()
    end
end

SLASH_SHOWD1 = "/syn";
SlashCmdList.SHOWD = function ()
    UIConfig:Toggle()
end

local function roll(maxValue)
    RandomRoll(1, maxValue)
    --UIConfig:Hide()
end

UIConfig.btnbis:SetScript("OnClick", function(...)
    roll(10)
end)

UIConfig.btn:SetScript("OnClick", function(...)
    roll(100)
end)

UIConfig.btn2:SetScript("OnClick", function(...)
    roll(99)
end)

UIConfig.btnPass:SetScript("OnClick", function(...)
    UIConfig:Hide()
end)
