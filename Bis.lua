local lib = LibStub("LibParse")

SyndicateDB = {}

SynBis = {
    frame = {
        main = nil,
        left = nil,
        right = nil,
        objet = {
            casque = {
                frame = nil,
                image = nil,
            },
            cou = {
                frame = nil,
                image = nil,
            },
            epaules = {
                frame = nil,
                image = nil,
            },
            cape = {
                frame = nil,
                image = nil,
            },
            torse = {
                frame = nil,
                image = nil,
            },
            brassards = {
                frame = nil,
                image = nil,
            },
            gants = {
                frame = nil,
                image = nil,
            },
            ceinture = {
                frame = nil,
                image = nil,
            },
            jambiere = {
                frame = nil,
                image = nil,
            },
            bottes = {
                frame = nil,
                image = nil,
            },
            anneau1 = {
                frame = nil,
                image = nil,
            },
            anneau2 = {
                frame = nil,
                image = nil,
            },
            bijou1 = {
                frame = nil,
                image = nil,
            },
            bijou2 = {
                frame = nil,
                image = nil,
            },
            arme1 = {
                frame = nil,
                image = nil,
            },
            arme2 = {
                frame = nil,
                image = nil,
            },
            arme3 = {
                frame = nil,
                image = nil,
            },
        }
    },
    items = {},
    placement = {
        casque = {x = 0, y = 0, pos = "left"},
        cou = {x = 0, y = -50, pos = "left"},
        epaules = {x = 0, y = -100, pos = "left"},
        cape = {x = 0, y = -150, pos = "left"},
        torse = {x = 0, y = -200, pos = "left"},
        brassards = {x = 0, y = -350, pos = "left"},
        gants = {x = 0, y = 0, pos = "right"},
        ceinture = {x = 0, y = -50, pos = "right"},
        jambiere = {x = 0, y = -100, pos = "right"},
        bottes = {x = 0, y = -150, pos = "right"},
        anneau1 = {x = 0, y = -200, pos = "right"},
        anneau2 = {x = 0, y = -250, pos = "right"},
        bijou1 = {x = 0, y = -300, pos = "right"},
        bijou2 = {x = 0, y = -350, pos = "right"},
        arme1 = {x = -52, y = 0, pos = "bottom"},
        arme2 = {x = 0, y = 0, pos = "bottom"},
        arme3 = {x = 52, y = 0, pos = "bottom"},
    },
    selected = { classe = nil, pseudo = nil },   
};

function SynBis:Create()
    ----------------
    -- MAIN FRAME --
    ----------------
    SynBis.frame.main = CreateFrame("Frame","BIS",UIParent,"BasicFrameTemplate");
    SynBis.frame.main:SetSize(400, 550);
    SynBis.frame.main:SetPoint("CENTER", UIParent, "CENTER", 0, 0); 
    SynBis.frame.main:SetMovable(true);
    SynBis.frame.main:SetClampedToScreen(true)
    SynBis.frame.main:SetScript("OnMouseDown", function (self, button)
      if button == "LeftButton" then
        self:StartMoving()
      end
    end)
    SynBis.frame.main:SetScript("OnMouseUp", function(self, button)
      self:StopMovingOrSizing()
    end)

    -----------
    -- TITLE --
    -----------
    SynBis.frame.main.title = SynBis.frame.main:CreateFontString(nil,"OVERLAY");
    SynBis.frame.main.title:SetFontObject("GameFontHighlight");
    SynBis.frame.main.title:SetPoint("CENTER", SynBis.frame.main.TitleBg, "CENTER", 0, 0);
    SynBis.frame.main.title:SetText("BIS LIST");

    --------------
    -- DROPDOWN --
    --------------
    dropDown = CreateFrame("FRAME", "WPDemoDropDown", SynBis.frame.main, "UIDropDownMenuTemplate");
    dropDown:SetPoint("TOPLEFT", SynBis.frame.main, "TOPLEFT", 10, -40);
    UIDropDownMenu_SetWidth(dropDown, 125);
    UIDropDownMenu_SetText(dropDown, "Choisir un personnage");

    -- Create menu
    UIDropDownMenu_Initialize(dropDown, function(self, level, menuList)
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

    function dropDown:SetValue(newValue)
        local regex = "(.*)_(.*)"
        local classe, pseudo = string.match(newValue, regex);
        SynBis.selected.classe = classe;
        SynBis.selected.pseudo = pseudo;
        SynBis:LoadBisList(classe, pseudo);
        CloseDropDownMenus()
    end



    ----------------
    -- LEFT FRAME --
    ----------------
    SynBis.frame.left = CreateFrame("Frame", "left", SynBis.frame.main);
    SynBis.frame.left:SetSize(100, 100);
    SynBis.frame.left:SetPoint("TOPLEFT", SynBis.frame.main, "TOPLEFT", 0, -50);

    -----------------
    -- RIGHT FRAME --
    -----------------
    SynBis.frame.right = CreateFrame("Frame", "right", SynBis.frame.main);
    SynBis.frame.right:SetSize(100, 100);
    SynBis.frame.right:SetPoint("TOPRIGHT", SynBis.frame.main, "TOPRIGHT", 0, -50);

    ------------------
    -- BOTTOM FRAME --
    ------------------
    SynBis.frame.bottom = CreateFrame("Frame", "bottom", SynBis.frame.main);
    SynBis.frame.bottom:SetSize(100, 100);
    SynBis.frame.bottom:SetPoint("BOTTOM", SynBis.frame.main, "BOTTOM", 0, 0);


    SynBis:CreateItemFrames()
    SynBis.frame.main:Hide();


end


function SynBis:CreateItemFrame(emplacement)
    SynBis.frame.objet[emplacement].frame = CreateFrame("Button", emplacement, SynBis.frame.main);
    SynBis.frame.objet[emplacement].frame:SetPoint("CENTER", SynBis.placement[emplacement].pos, "CENTER", SynBis.placement[emplacement].x, SynBis.placement[emplacement].y-10);
    SynBis.frame.objet[emplacement].frame:SetSize(48,48);
    SynBis.frame.objet[emplacement].frame:SetNormalFontObject("GameFontNormalLarge");
    SynBis.frame.objet[emplacement].frame:SetHighlightFontObject("GameFontHighlightLarge")
    SynBis.frame.objet[emplacement].image = SynBis.frame.objet[emplacement].frame:CreateTexture(nil, "BACKGROUND")
	SynBis.frame.objet[emplacement].image:SetWidth(48)
	SynBis.frame.objet[emplacement].image:SetHeight(48)
	SynBis.frame.objet[emplacement].image:SetPoint("TOP", 0, 10)
end

function SynBis:CreateItemFrames()
    for emplacement, _ in pairs(SynBis.frame.objet) do
        SynBis:CreateItemFrame(emplacement)
    end
    --SynBis:LoadBisList()
end

function SynBis:SetImage(idIcone, itemName, iLink, itemQuality, emplacement)
    SynBis.frame.objet[emplacement].image:SetTexture(idIcone)
    SynBis.frame.objet[emplacement].frame:SetScript("OnEnter", function(widget)
        GameTooltip:SetOwner(SynBis.frame.objet[emplacement].frame)
        GameTooltip:SetPoint("TOPRIGHT", SynBis.frame.objet[emplacement].frame, "TOPRIGHT", 220, -13);
        GameTooltip:SetHyperlink(iLink)
    end)
    SynBis.frame.objet[emplacement].frame:SetScript("OnLeave", function(widget)
        GameTooltip:Hide()
    end)
end

function SynBis:LoadBisList(classe, pseudo)
    for emplacement, idObjet in pairs(SyndicateDB[classe][pseudo]) do
        if(idObjet ~= 0) then
            objet = Item:CreateFromItemID(idObjet)
            objet:ContinueOnItemLoad(function()
                local idIcone = objet:GetItemIcon()
                local itemName = objet:GetItemName()
                local iLink = objet:GetItemLink()
                local itemQuality = objet:GetItemQuality()
                SynBis:SetImage(idIcone, itemName, iLink, itemQuality, emplacement)
        end)
        end
    end
end


SynBis:Create();

function SynBis:Toggle()
    if(SynBis.frame.main:IsShown()) then
        SynBis.frame.main:Hide()
    else
        SynBis.frame.main:Show()
    end
end