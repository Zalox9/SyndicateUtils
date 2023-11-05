local function DisplayExportFrame(input)
  if not SyndicateFrameExport then
    local frame = CreateFrame("Frame", "SyndicateFrameExport", UIParent, "DialogBoxFrame")
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

    local scrollFrame = CreateFrame("ScrollFrame", "GBAScroll", SyndicateFrameExport, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("LEFT", 16, 0)
    scrollFrame:SetPoint("Right", -32, 0)
    scrollFrame:SetPoint("TOP", 0, -32)
    scrollFrame:SetPoint("BOTTOM", SyndicateFrameExportButton, "TOP", 0, 0)

    local editFrame = CreateFrame("EditBox", "SyndicateFrameEdit", GBAScroll)
    editFrame:SetSize(scrollFrame:GetSize())
    editFrame:SetMultiLine(true)
    editFrame:SetAutoFocus(true)
    editFrame:SetFontObject("ChatFontNormal")
    editFrame:SetScript("OnEscapePressed", function() frame:Hide() end)
    scrollFrame:SetScrollChild(editFrame)
  end
  SyndicateFrameEdit:SetText(input)
  SyndicateFrameEdit:HighlightText()
  SyndicateFrameExport:Show()
end

local function Export()
    local outText = '';
    for _, value in pairs(SyndicateRoll) do
        outText = outText .. value .. ",\n";
    end
    return outText;
end

SLASH_SHOWEXPORT1 = "/synExport";
SlashCmdList.SHOWEXPORT = function ()
    DisplayExportFrame(Export())
end