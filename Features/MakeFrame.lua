SyndicateMaker = {}

function SyndicateMaker:makeFrame(name, parent, title, xSize, ySize)
    --------------------
    -- SETTINGS FRAME --
    --------------------
    self = CreateFrame("Frame", name, parent, BackdropTemplateMixin and 'BackdropTemplate');
    self:SetFrameStrata('DIALOG')
    self:SetSize(xSize, ySize);
    self:SetPoint("CENTER", parent, "CENTER", 0, 0); 
    self:SetMovable(true);
    self:SetClampedToScreen(true);
    self:SetBackdrop{
        bgFile='Interface\\DialogFrame\\UI-DialogBox-Background' ,
        edgeFile='Interface\\DialogFrame\\UI-DialogBox-Border',
        tile = true,
        insets = {left = 11, right = 12, top = 12, bottom = 11},
        tileSize = 32,
        edgeSize = 32,
	}

    self:SetBackdropColor(1, 1, 1, .85)

    self:SetScript("OnMouseDown", function (self, button)
      if button == "LeftButton" then
        self:StartMoving()
      end
    end)
    self:SetScript("OnMouseUp", function(self, button)
      self:StopMovingOrSizing()
    end)

    -----------
    -- TITLE --
    -----------
    self.header = self:CreateTexture(nil, 'ARTWORK');
	self.header:SetTexture('Interface\\DialogFrame\\UI-DialogBox-Header');
	self.header:SetWidth(326);
    self.header:SetHeight(64);
	self.header:SetPoint('TOP', 0, 12);

	self.title = self:CreateFontString('ARTWORK')
	self.title:SetFontObject('GameFontNormal')
	self.title:SetPoint('TOP', self.header, 'TOP', 0, -14)
	self.title:SetText(title)

    -----------
    -- CLOSE --
    -----------
	self.exitButton = CreateFrame('Button', 'ExitConfig', self, 'UIPanelCloseButton')
	self.exitButton:SetScript('OnClick', function()
        self:Hide()
    end)

	self.exitButton:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
		GameTooltip:SetText("Fermer la fênetre", nil, nil, nil, nil, 1)
	end)

	self.exitButton:SetScript('OnLeave', function(self)
		GameTooltip:Hide()
	end)
	self.exitButton:SetPoint('TOPRIGHT', -4, -4)
    return self;
end

function SyndicateMaker:CreateDropDown(name, parent, anchor, data, dataSelect, method)
    self = CreateFrame("FRAME", "WPDemoDropDown", parent, "UIDropDownMenuTemplate");
    self:SetPoint("TOPLEFT", anchor, "TOPLEFT", 10, -40);
    UIDropDownMenu_SetWidth(self, 125);
    UIDropDownMenu_SetText(self, "Choisir un personnage");

    function self:SetValue(newValue)
        local regex = "(.*)_(.*)"
        local classe, pseudo = string.match(newValue, regex);
        dataSelect.classe = classe;
        dataSelect.pseudo = pseudo;
        method(classe, pseudo, data)
        CloseDropDownMenus()
    end

    -- Create menu
    UIDropDownMenu_Initialize(self, function(self, level, menuList)
        local info = UIDropDownMenu_CreateInfo()
        -- level 1
        if (level or 1) == 1 then
        -- Display the 0-9, 10-19, ... groups
            for classe, _ in pairs(data) do
                info.text, info.checked = classe, classe == dataSelect.classe
                info.menuList, info.hasArrow = classe, true
                UIDropDownMenu_AddButton(info)
            end
        else
        -- level 2 (nested groups)
            info.func = self.SetValue
            for pseudo, _ in pairs(data[menuList]) do
                info.text, info.arg1, info.checked = pseudo, menuList .. "_".. pseudo, pseudo == dataSelect.pseudo
                UIDropDownMenu_AddButton(info, level)
            end
        end
    end)
    return self;
end

function SyndicateMaker:CreateItemFrame(name, parent, xCoord, yCoord, parentAnchor, selfPos, parentPos)
    self = CreateFrame("Button", name, parent);
    self:SetPoint(selfPos, parentAnchor ,parentPos, xCoord, yCoord);
    self:SetSize(24,24);
    self:SetNormalFontObject("GameFontNormalLarge");
    self:SetHighlightFontObject("GameFontHighlightLarge");

    self.image = self:CreateTexture(nil, "BACKGROUND");
	self.image:SetWidth(24);
	self.image:SetHeight(24);
	self.image:SetPoint("TOP", 0, 10);

    self.title = self:CreateFontString('ARTWORK');
	self.title:SetFontObject('GameFontNormal');
	self.title:SetPoint('LEFT', self, 'RIGHT', 10, 10);
	self.title:SetText("");
    return self;
end

function SyndicateMaker:SetItemFrame(frame, idIcone, itemName, iLink, itemQuality)
    frame.image:SetTexture(idIcone);
    frame.title:SetText(itemName);
    frame:SetScript("OnEnter", function(widget)
        GameTooltip:SetOwner(frame);
        GameTooltip:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 220, -13);
        GameTooltip:SetHyperlink(iLink);
    end)
    frame:SetScript("OnLeave", function(widget)
        GameTooltip:Hide();
    end)
end

function SyndicateMaker:SetItemFrameBis(idObjet, frame)
    local item = Item:CreateFromItemID(idObjet)
            item:ContinueOnItemLoad(function()
                local idIcone = item:GetItemIcon()
                local itemName = item:GetItemName()
                local iLink = item:GetItemLink()
                local itemQuality = item:GetItemQuality()
                local ilvl = item:GetCurrentItemLevel()
                SyndicateMaker:SetItemFrame(frame, idIcone, itemName, iLink, itemQuality, location)
            end)
end

function SyndicateMaker:ClearItemFrame(frame)
    frame.image:SetTexture("");
    frame.title:SetText("");
    frame:SetScript("OnEnter", function(widget)
        GameTooltip:Hide()
    end)
end