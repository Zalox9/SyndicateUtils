local lib = LibStub("LibParse")

SynImport = {};
local function DisplayImportFrame(input)
  if not SyndicateFrameImport then
    local frame = CreateFrame("Frame", "SyndicateFrameImport", UIParent, "DialogBoxFrame")
    frame:SetPoint("CENTER")
    frame:SetSize(500, 500)
    frame:SetBackdrop({
      bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
      edgeFile = "Interface\\PVPFrame\\UI-Character-PVP-Highlight",
      edgeSize = 16,
      insets = {left = 8, right = 8, top = 8, bottom = 8}
    })
    frame:SetMovable(true)
    frame:SetClampedToScreen(true)
    frame:SetScript("OnMouseDown", function (self, button)
      if button == "LeftButton" then
        self:StartMoving()
      end
    end)
    frame:SetScript("OnMouseUp", function(self, button)
      self:StopMovingOrSizing()
    end)

    local scrollFrame = CreateFrame("ScrollFrame", "GBAScroll", SyndicateFrameImport, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("LEFT", 16, 0)
    scrollFrame:SetPoint("Right", -32, 0)
    scrollFrame:SetPoint("TOP", 0, -32)
    scrollFrame:SetPoint("BOTTOM", SyndicateFrameImportButton, "TOP", 0, 0)

    local editFrame = CreateFrame("EditBox", "SyndicateFrameEdit", GBAScroll)
    editFrame:SetSize(scrollFrame:GetSize())
    editFrame:SetMultiLine(true)
    editFrame:SetAutoFocus(true)
    editFrame:SetFontObject("ChatFontNormal")
    editFrame:SetScript("OnEscapePressed", function() frame:Hide() end)
    scrollFrame:SetScrollChild(editFrame)

    SyndicateFrameImportButton:SetScript("OnClick", function(...)
        local textTable = lib:JSONDecode(SyndicateFrameEdit:GetText())
        SynBis.items = textTable
        SynBis:Create();
        SyndicateFrameImport:Hide();
    end)
  end
  SyndicateFrameEdit:HighlightText()
  SyndicateFrameImport:Show()
end


function SynImport:Create()
    SynImport.frame = CreateFrame("Frame", "SyndicateFrameImport", UIParent, "DialogBoxFrame")
    SynImport.frame:SetPoint("CENTER")
    SynImport.frame:SetSize(500, 500)
    SynImport.frame:SetBackdrop({
      bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
      edgeFile = "Interface\\PVPFrame\\UI-Character-PVP-Highlight",
      edgeSize = 16,
      insets = {left = 8, right = 8, top = 8, bottom = 8}
    })
    SynImport.frame:SetMovable(true)
    SynImport.frame:SetClampedToScreen(true)
    SynImport.frame:SetScript("OnMouseDown", function (self, button)
      if button == "LeftButton" then
        self:StartMoving()
      end
    end)
    SynImport.frame:SetScript("OnMouseUp", function(self, button)
      self:StopMovingOrSizing()
    end)

    local scrollFrame = CreateFrame("ScrollFrame", "GBAScroll", SyndicateFrameImport, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("LEFT", 16, 0)
    scrollFrame:SetPoint("Right", -32, 0)
    scrollFrame:SetPoint("TOP", 0, -32)
    scrollFrame:SetPoint("BOTTOM", SyndicateFrameImportButton, "TOP", 0, 0)

    local editFrame = CreateFrame("EditBox", "SyndicateFrameEdit", GBAScroll)
    editFrame:SetSize(scrollFrame:GetSize())
    editFrame:SetMultiLine(true)
    editFrame:SetAutoFocus(true)
    editFrame:SetFontObject("ChatFontNormal")
    editFrame:SetScript("OnEscapePressed", function() SynImport.frame:Hide() end)
    scrollFrame:SetScrollChild(editFrame)

    SyndicateFrameImportButton:SetScript("OnClick", function(...)
        local textTable = lib:JSONDecode(SyndicateFrameEdit:GetText());
        SynBis.items = textTable;
        SyndicateDB = textTable;
        SyndicateFrameImport:Hide();
    end)
end

SynImport:Create()

function SynImport:Toggle()
    if(SynImport.frame:IsShown()) then
        SynImport.frame:Hide()
    else
        SynImport.frame:Show()
    end
end

