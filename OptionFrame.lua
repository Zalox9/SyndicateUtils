OptionFrame = CreateFrame("Frame", "Option_Frame", UIParent, "BasicFrameTemplateWithInset");
OptionFrame:SetSize(300,125);
OptionFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 200); 

--- CHILD FRAMES AND REGIONS:
OptionFrame.title = OptionFrame:CreateFontString(nil,"OVERLAY");
OptionFrame.title:SetFontObject("GameFontHighlight");
OptionFrame.title:SetPoint("CENTER", OptionFrame.TitleBg, "CENTER", 0, 0);
OptionFrame.title:SetText("Syndicate BL");


-------------
-- disable ACTIVER --
-------------
OptionFrame.enable = CreateFrame("Button", nil, OptionFrame, "GameMenuButtonTemplate");
OptionFrame.enable:SetPoint("CENTER", OptionFrame, "TOP", -75, -70);
OptionFrame.enable:SetSize(140,40);
OptionFrame.enable:SetText("ACTIVER")
OptionFrame.enable:SetNormalFontObject("GameFontNormalLarge");
OptionFrame.enable:SetHighlightFontObject("GameFontHighlightLarge")

-------------
-- disable DESACTIVER --
-------------
OptionFrame.disable = CreateFrame("Button", nil, OptionFrame, "GameMenuButtonTemplate");
OptionFrame.disable:SetPoint("CENTER", OptionFrame, "TOP", 75, -70);
OptionFrame.disable:SetSize(140,40);
OptionFrame.disable:SetText("DESACTIVER")
OptionFrame.disable:SetNormalFontObject("GameFontNormalLarge");
OptionFrame.disable:SetHighlightFontObject("GameFontHighlightLarge")

function OptionFrame:Toggle()
    if(OptionFrame:IsShown()) then
        OptionFrame:Hide()
    else
        OptionFrame:Show()
    end
end

OptionFrame.enable:SetScript("OnClick", function(...)
    print("DEBUT DE L'ENREGISTREMENT DES RANDS")
    isActive = true
end)

OptionFrame.disable:SetScript("OnClick", function(...)
    print("FIN DE L'ENREGISTREMENT DES RANDS")
    isActive = false
end)

SLASH_SYNOP1 = "/synOp";
SlashCmdList.SYNOP = function ()
    OptionFrame:Toggle()
end

OptionFrame:Hide()