SyndicateBisSettings = {
    frames = {
        main=nil
    },
    isInit=false,
    comeBack=false,
}

local function isDataBislistNotEmpty()
    if(SyndicateDB.bislist == nil) then
        return false
    else
        return true
    end
end 

local function isSyndicateDBPlayerBisIsNotEmpty()
    if(SyndicateDBPlayerBis == nil) then
        return false
    else 
        return true
    end
end


function SyndicateBisSettings:CreateFrameSettings()
    --------------------
    -- SETTINGS FRAME --
    --------------------
    SyndicateBisSettings.frames.main = CreateFrame("Frame","BISSETTINGS",UIParent,BackdropTemplateMixin and 'BackdropTemplate');
    SyndicateBisSettings.frames.main:SetFrameStrata('DIALOG')
    SyndicateBisSettings.frames.main:SetSize(400, 250);
    SyndicateBisSettings.frames.main:SetPoint("CENTER", UIParent, "CENTER", 0, 0); 
    SyndicateBisSettings.frames.main:SetMovable(true);
    SyndicateBisSettings.frames.main:SetClampedToScreen(true);
    SyndicateBisSettings.frames.main:SetBackdrop{
        bgFile='Interface\\DialogFrame\\UI-DialogBox-Background' ,
        edgeFile='Interface\\DialogFrame\\UI-DialogBox-Border',
        tile = true,
        insets = {left = 11, right = 12, top = 12, bottom = 11},
        tileSize = 32,
        edgeSize = 32,
	}

    SyndicateBisSettings.frames.main:SetBackdropColor(1, 1, 1, .85)

    SyndicateBisSettings.frames.main:SetScript("OnMouseDown", function (self, button)
      if button == "LeftButton" then
        self:StartMoving()
      end
    end)
    SyndicateBisSettings.frames.main:SetScript("OnMouseUp", function(self, button)
      self:StopMovingOrSizing()
    end)

    -----------
    -- TITLE --
    -----------
    SyndicateBisSettings.frames.main.header = SyndicateBisSettings.frames.main:CreateTexture(nil, 'ARTWORK');
	SyndicateBisSettings.frames.main.header:SetTexture('Interface\\DialogFrame\\UI-DialogBox-Header');
	SyndicateBisSettings.frames.main.header:SetWidth(326);
    SyndicateBisSettings.frames.main.header:SetHeight(64);
	SyndicateBisSettings.frames.main.header:SetPoint('TOP', 0, 12);
	SyndicateBisSettings.frames.main.title = SyndicateBisSettings.frames.main:CreateFontString('ARTWORK')
	SyndicateBisSettings.frames.main.title:SetFontObject('GameFontNormal')
	SyndicateBisSettings.frames.main.title:SetPoint('TOP', SyndicateBisSettings.frames.main.header, 'TOP', 0, -14)
	SyndicateBisSettings.frames.main.title:SetText(SyndicateMessage.SettingsBis.header)

    -----------
    -- CLOSE --
    -----------
	SyndicateBisSettings.frames.main.exitButton = CreateFrame('Button', 'ExitConfig', SyndicateBisSettings.frames.main, 'UIPanelCloseButton')
	SyndicateBisSettings.frames.main.exitButton:SetScript('OnClick', function()
        SyndicateBisSettings.frames.main:Hide()
    end)

	SyndicateBisSettings.frames.main.exitButton:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
		GameTooltip:SetText("Fermer la fênetre", nil, nil, nil, nil, 1)
	end)

	SyndicateBisSettings.frames.main.exitButton:SetScript('OnLeave', function(self)
		GameTooltip:Hide()
	end)
	SyndicateBisSettings.frames.main.exitButton:SetPoint('TOPRIGHT', -4, -4)

    -------------
    -- MESSAGE --
    -------------
    SyndicateBisSettings.frames.main.message = SyndicateBisSettings.frames.main:CreateFontString('ARTWORK')
	SyndicateBisSettings.frames.main.message:SetFontObject('GameFontNormal')
	SyndicateBisSettings.frames.main.message:SetPoint('TOP', SyndicateBisSettings.frames.main, 'TOP', 0, -35)
	SyndicateBisSettings.frames.main.message:SetText(SyndicateMessage.SettingsBis.message)


    -------------------
    -- BTN DATA LIST --
    -------------------
    -- DATA --
    SyndicateBisSettings.frames.main.messagedata = SyndicateBisSettings.frames.main:CreateFontString('ARTWORK')
	SyndicateBisSettings.frames.main.messagedata:SetFontObject('GameFontNormal')
	SyndicateBisSettings.frames.main.messagedata:SetPoint('CENTER', SyndicateBisSettings.frames.main.message, 'BOTTOM', 0, -25)
	SyndicateBisSettings.frames.main.messagedata:SetText("- DATA -")

    SyndicateBisSettings.frames.main.btndata = CreateFrame("Button", nil, SyndicateBisSettings.frames.main, "GameMenuButtonTemplate");
    SyndicateBisSettings.frames.main.btndata:SetPoint("CENTER", SyndicateBisSettings.frames.main.messagedata, "BOTTOM", 0, -25);
    SyndicateBisSettings.frames.main.btndata:SetSize(130,30);
    local state = "Charger de la data"
    if(isDataBislistNotEmpty())then
        state = "Changer la data"
    end
    SyndicateBisSettings.frames.main.btndata:SetText(state)
    SyndicateBisSettings.frames.main.btndata:SetNormalFontObject("GameFontNormalLarge");
    SyndicateBisSettings.frames.main.btndata:SetHighlightFontObject("GameFontHighlightLarge")

    SyndicateBisSettings.frames.main.btndata:SetScript("OnClick", function(...)
        SyndicateBisSettings.comeBack = true;
        SyndicateBisSettings:Toggle();
        SynImport:Toggle();
    end)


    ---------------------
    -- BTN PLAYER INIT --
    ---------------------
    -- STATE --
    SyndicateBisSettings.frames.main.messageplayer = SyndicateBisSettings.frames.main:CreateFontString('ARTWORK')
	SyndicateBisSettings.frames.main.messageplayer:SetFontObject("GameFontNormal")
	SyndicateBisSettings.frames.main.messageplayer:SetPoint("CENTER", SyndicateBisSettings.frames.main.btndata, "BOTTOM", 0, -25)
	SyndicateBisSettings.frames.main.messageplayer:SetText("- MON PERSONNAGE -")


    --------------
    -- DROPDOWN --
    --------------
    SyndicateBisSettings.frames.dropDown = CreateFrame("FRAME", "WPDemoDropDown", SyndicateBisSettings.frames.main, "UIDropDownMenuTemplate");
    SyndicateBisSettings.frames.dropDown:SetPoint("CENTER", SyndicateBisSettings.frames.main.messageplayer, "BOTTOM", -100, -25);
    UIDropDownMenu_SetWidth(SyndicateBisSettings.frames.dropDown, 125);
    UIDropDownMenu_SetText(SyndicateBisSettings.frames.dropDown, "Choisir un personnage");

    -- Create menu
    UIDropDownMenu_Initialize(SyndicateBisSettings.frames.dropDown, function(self, level, menuList)
        local info = UIDropDownMenu_CreateInfo()
        -- level 1
        if (level or 1) == 1 then
        -- Display the 0-9, 10-19, ... groups
        if(SyndicateDB.bislist ~= nil) then
           for classe, _ in pairs(SyndicateDB.bislist) do
                info.text, info.checked = classe, classe == SyndicateDBPlayerBis.classe
                info.menuList, info.hasArrow = classe, true
                UIDropDownMenu_AddButton(info)
            end 
        end
        else
        -- level 2 (nested groups)
            info.func = self.SetValue
            if(SyndicateDB.bislist ~= nil) then
                for pseudo, _ in pairs(SyndicateDB.bislist[menuList]) do
                    info.text, info.arg1, info.checked = pseudo, menuList .. "_".. pseudo, pseudo == SyndicateDBPlayerBis.pseudo
                    UIDropDownMenu_AddButton(info, level)
                end
            end
        end
    end)
    function SyndicateBisSettings.frames.dropDown:SetValue(newValue)
        local regex = "(.*)_(.*)"
        local classe, pseudo = string.match(newValue, regex);
        SyndicateDBPlayerBis.classe = classe;
        SyndicateDBPlayerBis.pseudo = pseudo;
        CloseDropDownMenus();
        SyndicateBisSettings.frames.main:Hide()
        SynBis:Toggle();
    end

    -----------------------
    -- BTN NO PERSONNAGE --
    -----------------------
    SyndicateBisSettings.frames.main.btnplayer = CreateFrame("Button", nil, SyndicateBisSettings.frames.main, "GameMenuButtonTemplate");
    SyndicateBisSettings.frames.main.btnplayer:SetPoint("LEFT", SyndicateBisSettings.frames.dropDown, "RIGHT", 10, 0);
    SyndicateBisSettings.frames.main.btnplayer:SetSize(170,30);
    SyndicateBisSettings.frames.main.btnplayer:SetText(SyndicateMessage.SettingsBis.btnnoplayer)
    SyndicateBisSettings.frames.main.btnplayer:SetNormalFontObject("GameFontNormalLarge");
    SyndicateBisSettings.frames.main.btnplayer:SetHighlightFontObject("GameFontHighlightLarge")

    SyndicateBisSettings.frames.main.btnplayer:SetScript("OnClick", function(...)
        SyndicateDBPlayerBis.pseudo = ""
        SyndicateDBPlayerBis.classe = nil
        SyndicateBisSettings:Toggle();
    end)

end


function SyndicateBisSettings:Toggle()
    if(SyndicateBisSettings.isInit) then
        if(SyndicateBisSettings.frames.main:IsShown()) then
            SyndicateBisSettings.frames.main:Hide()
        else
            SyndicateBisSettings.frames.main:Show()
        end
    else
        SyndicateBisSettings:CreateFrameSettings();
        SyndicateBisSettings.isInit=true;
    end
end


SlashCmdList['SYNDICATEINIT'] = function(msg)
    SyndicateBisSettings:Toggle();
end
SLASH_SYNDICATEINIT1 = '/syninit'