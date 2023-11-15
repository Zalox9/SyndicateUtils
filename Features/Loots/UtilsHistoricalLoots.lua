----------------
-- Namespaces --
----------------
local _, core = ...;
core.UtilsHistoricalLoots = {};

local UtilsHistoricalLoots = core.UtilsHistoricalLoots;

function UtilsHistoricalLoots:CreateItemFrame(name, parent, xCoord, yCoord, parentAnchor, selfPos, parentPos)
    self = CreateFrame("Button", name, parent);
    self:SetPoint(selfPos, parentAnchor ,parentPos, xCoord, yCoord);
    self:SetSize(36,36);
    self:SetNormalFontObject("GameFontNormalLarge");
    self:SetHighlightFontObject("GameFontHighlightLarge");

    self.image = self:CreateTexture(nil, "BACKGROUND");
	self.image:SetWidth(36);
	self.image:SetHeight(36);
	self.image:SetPoint("CENTER", 0, 0);

    self.title = self:CreateFontString('ARTWORK');
	self.title:SetFontObject('GameFontNormal');
	self.title:SetPoint('LEFT', self, 'RIGHT', 10, 0);
	self.title:SetText("NAME");

    self.reason = self:CreateFontString('ARTWORK');
    self.reason:SetFontObject('GameFontNormal');
	self.reason:SetPoint('LEFT', self.title, 'RIGHT', 10, 0);
	self.reason:SetText("REASON");

    self.date = self:CreateFontString('ARTWORK');
    self.date:SetFontObject('GameFontNormal');
	self.date:SetPoint('LEFT', self.reason, 'RIGHT', 10, 0);
	self.date:SetText("DATE");

    self.count = self:CreateFontString('ARTWORK');
    self.count:SetFontObject('GameFontNormal');
	self.count:SetPoint('RIGHT', self, 'BOTTOMRIGHT', -5, 10);
	self.count:SetText("COUNT");
    return self;
end

function UtilsHistoricalLoots:SetItemFrame(frame, idIcone, itemName, iLink, itemQuality)
    frame.image:SetTexture(idIcone);
    frame.title:SetText(iLink);
    frame:SetScript("OnEnter", function(widget)
        GameTooltip:SetOwner(frame);
        GameTooltip:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 220, -13);
        GameTooltip:SetHyperlink(iLink);
    end)
    frame:SetScript("OnLeave", function(widget)
        GameTooltip:Hide();
    end)
end

function UtilsHistoricalLoots:SetItemFrameBis(frame, idObjet, reason, date, count)
    local item = Item:CreateFromItemID(idObjet)
    item:ContinueOnItemLoad(function()
        local idIcone = item:GetItemIcon()
        local itemName = item:GetItemName()
        local iLink = item:GetItemLink()
        local itemQuality = item:GetItemQuality()
        local ilvl = item:GetCurrentItemLevel()
        UtilsHistoricalLoots:SetItemFrame(frame, idIcone, itemName, iLink, itemQuality, location)
    end)
    frame.reason:SetText(reason);
    frame.date:SetText(date);
    frame.count:SetText(count > 1 and count or "");
end