local lib = LibStub("LibParse")


SynBis = {
    frames = {
        main = nil,
        left = nil,
        right = nil,
        model = nil,
        dropDown = nil,
        items = {
            slot_1 = {
                frame = nil,
                image = nil,
            },
            slot_2 = {
                frame = nil,
                image = nil,
            },
            slot_3 = {
                frame = nil,
                image = nil,
            },
            slot_15 = {
                frame = nil,
                image = nil,
            },
            slot_5 = {
                frame = nil,
                image = nil,
            },
            slot_9 = {
                frame = nil,
                image = nil,
            },
            slot_10 = {
                frame = nil,
                image = nil,
            },
            slot_6 = {
                frame = nil,
                image = nil,
            },
            slot_7 = {
                frame = nil,
                image = nil,
            },
            slot_8 = {
                frame = nil,
                image = nil,
            },
            slot_11 = {
                frame = nil,
                image = nil,
            },
            slot_12 = {
                frame = nil,
                image = nil,
            },
            slot_13 = {
                frame = nil,
                image = nil,
            },
            slot_14 = {
                frame = nil,
                image = nil,
            },
            slot_16 = {
                frame = nil,
                image = nil,
            },
            slot_17 = {
                frame = nil,
                image = nil,
            },
            slot_18 = {
                frame = nil,
                image = nil,
            },
        }
    },
    items = {},
    location = {
        slot_1 = {x = 0, y = 0, pos = "left"},
        slot_2 = {x = 0, y = -50, pos = "left"},
        slot_3 = {x = 0, y = -100, pos = "left"},
        slot_15 = {x = 0, y = -150, pos = "left"},
        slot_5 = {x = 0, y = -200, pos = "left"},
        slot_9 = {x = 0, y = -350, pos = "left"},
        slot_10 = {x = 0, y = 0, pos = "SynBisAnchorRight"},
        slot_6 = {x = 0, y = -50, pos = "SynBisAnchorRight"},
        slot_7 = {x = 0, y = -100, pos = "SynBisAnchorRight"},
        slot_8 = {x = 0, y = -150, pos = "SynBisAnchorRight"},
        slot_11 = {x = 0, y = -200, pos = "SynBisAnchorRight"},
        slot_12 = {x = 0, y = -250, pos = "SynBisAnchorRight"},
        slot_13 = {x = 0, y = -300, pos = "SynBisAnchorRight"},
        slot_14 = {x = 0, y = -350, pos = "SynBisAnchorRight"},
        slot_16 = {x = -52, y = 0, pos = "bottom"},
        slot_17 = {x = 0, y = 0, pos = "bottom"},
        slot_18 = {x = 52, y = 0, pos = "bottom"},
    },
    selected = { classe = nil, pseudo = nil },
    emptySlot = {
        slot_1 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_head.tga",
        slot_2 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_neck.tga",
        slot_3 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_shoulder.tga",
        slot_15 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_chest.tga",
        slot_5 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_chest.tga",
        slot_9 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_wrists.tga",
        slot_10 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_hands.tga",
        slot_6 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_waist.tga",
        slot_7 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_legs.tga",
        slot_8 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_feet.tga",
        slot_11 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_finger.tga",
        slot_12 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_finger.tga",
        slot_13 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_trinket.tga",
        slot_14 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_trinket.tga",
        slot_16 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_mainhand.tga",
        slot_17 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_offhand.tga",
        slot_18 = "Interface\\Addons\\Syndicate\\Media\\emptySlot\\inventoryslot_ranged.tga",
    }   
};

local function copyDefaults(src, dst)
    -- If no source (defaults) is specified, return an empty table:
    if type(src) ~= "table" then return {} end
    -- If no target (saved variable) is specified, create a new table:
    if not type(dst) then dst = {} end
    -- Loop through the source (defaults):
    for k, v in pairs(src) do
        -- If the value is a sub-table:
        if type(v) == "table" then
            -- Recursively call the function:
            dst[k] = copyDefaults(v, dst[k])
        -- Or if the default value type doesn't match the existing value type:
        elseif type(v) ~= type(dst[k]) then
            -- Overwrite the existing value with the default one:
            dst[k] = v
        end
    end
    -- Return the destination table:
    return dst
end

SyndicateDB = copyDefaults(SyndicateDB, SyndicateDB)





function SynBis:Create()
    ----------------
    -- MAIN FRAME --
    ----------------
    SynBis.frames.main = CreateFrame("Frame","BIS",UIParent,BackdropTemplateMixin and 'BackdropTemplate');
    SynBis.frames.main:SetFrameStrata('DIALOG')
    SynBis.frames.main:SetSize(400, 550);
    SynBis.frames.main:SetPoint("CENTER", UIParent, "CENTER", 0, 0); 
    SynBis.frames.main:SetMovable(true);
    SynBis.frames.main:SetClampedToScreen(true);
    SynBis.frames.main:SetBackdrop{
        bgFile='Interface\\DialogFrame\\UI-DialogBox-Background' ,
        edgeFile='Interface\\DialogFrame\\UI-DialogBox-Border',
        tile = true,
        insets = {left = 11, right = 12, top = 12, bottom = 11},
        tileSize = 32,
        edgeSize = 32,
	}

    SynBis.frames.main:SetBackdropColor(1, 1, 1, .85)

    SynBis.frames.main:SetScript("OnMouseDown", function (self, button)
      if button == "LeftButton" then
        self:StartMoving()
      end
    end)
    SynBis.frames.main:SetScript("OnMouseUp", function(self, button)
      self:StopMovingOrSizing()
    end)

    -----------
    -- TITLE --
    -----------

    SynBis.frames.main.header = SynBis.frames.main:CreateTexture(nil, 'ARTWORK');
	SynBis.frames.main.header:SetTexture('Interface\\DialogFrame\\UI-DialogBox-Header');
	SynBis.frames.main.header:SetWidth(326);
    SynBis.frames.main.header:SetHeight(64);
	SynBis.frames.main.header:SetPoint('TOP', 0, 12);

	SynBis.frames.main.title = SynBis.frames.main:CreateFontString('ARTWORK')
	SynBis.frames.main.title:SetFontObject('GameFontNormal')
	SynBis.frames.main.title:SetPoint('TOP', SynBis.frames.main.header, 'TOP', 0, -14)
	SynBis.frames.main.title:SetText("BIS LIST")


    -----------
    -- CLOSE --
    -----------
	SynBis.frames.main.exitButton = CreateFrame('Button', 'ExitConfig', SynBis.frames.main, 'UIPanelCloseButton')
	SynBis.frames.main.exitButton:SetScript('OnClick', function()
        SynBis.frames.main:Hide()
    end)

	SynBis.frames.main.exitButton:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
		GameTooltip:SetText("Fermer la fênetre", nil, nil, nil, nil, 1)
	end)

	SynBis.frames.main.exitButton:SetScript('OnLeave', function(self)
		GameTooltip:Hide()
	end)
	SynBis.frames.main.exitButton:SetPoint('TOPRIGHT', -4, -4)

    --------------
    -- DROPDOWN --
    --------------
    SynBis.frames.dropDown = CreateFrame("FRAME", "WPDemoDropDown", SynBis.frames.main, "UIDropDownMenuTemplate");
    SynBis.frames.dropDown:SetPoint("TOPLEFT", SynBis.frames.main, "TOPLEFT", 10, -40);
    UIDropDownMenu_SetWidth(SynBis.frames.dropDown, 125);
    UIDropDownMenu_SetText(SynBis.frames.dropDown, "Choisir un personnage");

    -- Create menu
    UIDropDownMenu_Initialize(SynBis.frames.dropDown, function(self, level, menuList)
        local info = UIDropDownMenu_CreateInfo()
        -- level 1
        if (level or 1) == 1 then
        -- Display the 0-9, 10-19, ... groups
            for classe, _ in pairs(SyndicateDB) do
                info.text, info.checked = classe, classe == SynBis.selected.classe
                info.menuList, info.hasArrow = classe, true
                UIDropDownMenu_AddButton(info)
            end
        else
        -- level 2 (nested groups)
            info.func = self.SetValue
            for pseudo, _ in pairs(SyndicateDB[menuList]) do
                info.text, info.arg1, info.checked = pseudo, menuList .. "_".. pseudo, pseudo == SynBis.selected.pseudo
                UIDropDownMenu_AddButton(info, level)
            end
        end
    end)

    function SynBis.frames.dropDown:SetValue(newValue)
        local regex = "(.*)_(.*)"
        local classe, pseudo = string.match(newValue, regex);
        SynBis.selected.classe = classe;
        SynBis.selected.pseudo = pseudo;
        SynBis:LoadBisList(classe, pseudo);
        CloseDropDownMenus()
    end

    ---------
    -- NOM --
    ---------
    SynBis.frames.main.playerName = SynBis.frames.main:CreateFontString('ARTWORK')
	SynBis.frames.main.playerName:SetFontObject('GameFontNormal')
	SynBis.frames.main.playerName:SetPoint('LEFT', SynBis.frames.dropDown, "RIGHT", 50, 0)
	SynBis.frames.main.playerName:SetText("")


    ----------------
    -- LEFT FRAME --
    ----------------
    SynBis.frames.left = CreateFrame("Frame", "left", SynBis.frames.main);
    SynBis.frames.left:SetSize(100, 100);
    SynBis.frames.left:SetPoint("TOPLEFT", SynBis.frames.main, "TOPLEFT", 0, -50);

    -----------------
    -- RIGHT FRAME --
    -----------------
    SynBis.frames.right = CreateFrame("Frame", "SynBisAnchorRight", SynBis.frames.main);
    SynBis.frames.right:SetSize(100, 100);
    SynBis.frames.right:SetPoint("TOPRIGHT", SynBis.frames.main, "TOPRIGHT", 0, -50);

    ------------------
    -- BOTTOM FRAME --
    ------------------
    SynBis.frames.bottom = CreateFrame("Frame", "bottom", SynBis.frames.main);
    SynBis.frames.bottom:SetSize(100, 100);
    SynBis.frames.bottom:SetPoint("BOTTOM", SynBis.frames.main, "BOTTOM", 0, 0);


    SynBis:CreateItemFrames();
    SynBis.frames.main:Hide();


end


function SynBis:CreateItemFrame(location)
    SynBis.frames.items[location].frame = CreateFrame("Button", location, SynBis.frames.main);
    SynBis.frames.items[location].frame:SetPoint("CENTER", SynBis.location[location].pos, "CENTER", SynBis.location[location].x, SynBis.location[location].y-10);
    SynBis.frames.items[location].frame:SetSize(48,48);
    SynBis.frames.items[location].frame:SetNormalFontObject("GameFontNormalLarge");
    SynBis.frames.items[location].frame:SetHighlightFontObject("GameFontHighlightLarge")

    SynBis.frames.items[location].image = SynBis.frames.items[location].frame:CreateTexture(nil, "BACKGROUND")
	SynBis.frames.items[location].image:SetWidth(48)
	SynBis.frames.items[location].image:SetHeight(48)
	SynBis.frames.items[location].image:SetPoint("TOP", 0, 10)
    SynBis.frames.items[location].image:SetTexture(SynBis.emptySlot[location])

    SynBis.frames.items[location].title = SynBis.frames.items[location].frame:CreateFontString('ARTWORK')
	SynBis.frames.items[location].title:SetFontObject('GameFontNormal')
    local x, y = nil, nil
    if(SynBis.location[location].pos == "left") then
        x = 50;
        y = -10;
    elseif(SynBis.location[location].pos == "SynBisAnchorRight") then
        x = -27;
        y = -10;
    else
        x = 13;
        y = 20;
    end
	SynBis.frames.items[location].title:SetPoint('RIGHT', SynBis.frames.items[location].frame, 'TOP', x, y)
	SynBis.frames.items[location].title:SetText("ILVL")


end

function SynBis:CreateItemFrames()
    for location, _ in pairs(SynBis.frames.items) do
        SynBis:CreateItemFrame(location)
    end
    --SynBis:LoadBisList()
end

function SynBis:SetImage(idIcone, itemName, iLink, itemQuality, location)
    SynBis.frames.items[location].image:SetTexture(idIcone)
    SynBis.frames.items[location].frame:SetScript("OnEnter", function(widget)
        GameTooltip:SetOwner(SynBis.frames.items[location].frame)
        GameTooltip:SetPoint("TOPRIGHT", SynBis.frames.items[location].frame, "TOPRIGHT", 220, -13);
        GameTooltip:SetHyperlink(iLink)
    end)
    SynBis.frames.items[location].frame:SetScript("OnLeave", function(widget)
        GameTooltip:Hide()
    end)
end

function SynBis:LoadBisList(classe, pseudo)
    SynBis.frames.main.playerName:SetText(pseudo)
    for location, idObjet in pairs(SyndicateDB[classe][pseudo]) do
        local regex = ".*_(%d+)"
        local slotNumber = string.match(location, regex);
        local isWeapon = false;
        local handSlot = nil;
        if(slotNumber == 16) then 
            isWeapon = true;
            handSlot = "MAINHANDSLOT"
        elseif(slotNumber == 17) then
            isWeapon = true;
            handSlot = "SECONDARYHANDSLOT"
        end
        if(idObjet ~= 0) then
            local item = Item:CreateFromItemID(idObjet)
            item:ContinueOnItemLoad(function()
                local idIcone = item:GetItemIcon()
                local itemName = item:GetItemName()
                local iLink = item:GetItemLink()
                local itemQuality = item:GetItemQuality()
                local ilvl = item:GetCurrentItemLevel()
                SynBis:SetImage(idIcone, itemName, iLink, itemQuality, location)
                if(isWeapon) then
                    SynBis.frames.model:TryOn(iLink, handSlot)
                else
                    SynBis.frames.model:TryOn(iLink)
                end
                SynBis.frames.items[location].title:SetText(ilvl)
            end)
        else
            SynBis.frames.items[location].image:SetTexture(SynBis.emptySlot[location]) 
            SynBis.frames.items[location].title:SetText("ILVL")
            SynBis.frames.model:UndressSlot(slotNumber)
        end
    end
end

function SynBis:CreateModel()
    SynBis.frames.model = CreateFrame("DressUpModel", nil, SynBis.frames.main);
    SynBis.frames.model:SetPoint("CENTER");
    SynBis.frames.model:SetSize(450,450)
    SynBis.frames.model:SetUnit('player')
end

SynBis:Create();

function SynBis:Toggle()
    if(SynBis.frames.main:IsShown()) then
        SynBis.frames.main:Hide()
    else
        SynBis.frames.main:Show()
        if(SynBis.selected.classe ~= nil) then
            SynBis:LoadBisList(SynBis.selected.classe, SynBis.selected.pseudo);
        end
    end
end

    SynBis:CreateModel();
