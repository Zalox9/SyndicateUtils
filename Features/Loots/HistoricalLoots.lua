----------------
-- Namespaces --
----------------
local _, core = ...;
local UtilsHistoricalLoots = core.UtilsHistoricalLoots;
core.SyndicateHistoricalLoots = {}

local SyndicateHistoricalLoots = core.SyndicateHistoricalLoots
SyndicateHistoricalLoots.checkValue = {
    showBis = true,
    show1 = true,
    show2 = true
}
SyndicateHistoricalLoots.currentPlayer = {
    classe = nil,
    name = nil,
}
framepool = {}
framepoolUse = {}


function SyndicateHistoricalLoots:removeAllFrame(tableFrame)
        local size = #tableFrame
        for i=0, size do
            SyndicateHistoricalLoots:removeFrame(tremove(tableFrame))
        end
end

function SyndicateHistoricalLoots:removeFrame(frame)
    if(frame ~= nil) then
        SyndicateMaker:ClearItemFrame(frame)
        frame:SetParent(nil)
		frame:ClearAllPoints()
        frame:Hide()
        tinsert(framepool, frame)
    end
end

function SyndicateHistoricalLoots:getFrame(parentAnchor, isFirst)
    local frame = tremove(framepool)
    local selfPos = "TOPLEFT"
    local parentPos = "TOPLEFT"
    local x, y = 10, -10
    if(isFirst == false) then
        x, y = 0, 0;
        selfPos = "TOP"
        parentPos = "BOTTOM"
    end
    if not frame then
        frame = UtilsHistoricalLoots:CreateItemFrame(nil, SyndicateHistoricalLoots.frame.body.moduleoptions, x, y, parentAnchor, selfPos, parentPos);
    else
        frame:SetParent(SyndicateHistoricalLoots.frame.body.moduleoptions)
        frame:SetPoint(selfPos, parentAnchor ,parentPos, x, y);
        frame:Show();
    end
    tinsert(framepoolUse, frame)
    return frame
end

function loadLoot(classe, pseudo, data)
    SyndicateHistoricalLoots.frame.playerName:SetText(pseudo)
    SyndicateHistoricalLoots:removeAllFrame(framepoolUse);
    local refFrame = nil;
    for round, entries in pairs(data[classe][pseudo]) do
        local conditionBis = SyndicateHistoricalLoots.checkValue.showBis == true and entries.attribution == "bis";
        local condition1 = SyndicateHistoricalLoots.checkValue.show1 == true and entries.attribution == "+1";
        local condition2 = SyndicateHistoricalLoots.checkValue.show2 == true and entries.attribution == "+2";
        if (conditionBis or condition1 or condition2) then
            if(refFrame == nil) then
                refFrame = SyndicateHistoricalLoots:getFrame(SyndicateHistoricalLoots.frame.body.moduleoptions, true)
            else
                refFrame = SyndicateHistoricalLoots:getFrame(refFrame, false)
            end
            UtilsHistoricalLoots:SetItemFrameBis(refFrame, entries.idObjet, entries.attribution, entries.date, entries.number);
        end
    end
end

function CheckDb(classe, pseudo, data)
    if(classe ~= nil and pseudo ~= nil and data ~= nid) then
        if(data[classe] ~= nil and data[classe][pseudo] ~= nil) then
            SyndicateHistoricalLoots.currentPlayer.name = SyndicateDBPlayerBis.pseudo;
            SyndicateHistoricalLoots.currentPlayer.classe = SyndicateDBPlayerBis.classe;
            loadLoot(SyndicateDBPlayerBis.classe, SyndicateDBPlayerBis.pseudo, SyndicateDB.loot);
        end
    end

end

function SyndicateHistoricalLoots:toggle()
    if(SyndicateHistoricalLoots.frame == nil) then
        SyndicateHistoricalLoots.frame = SyndicateMaker:makeFrame(nil, UIParent, "Historique de loots", 400, 500);
        SyndicateHistoricalLoots.frame.dropdown = SyndicateMaker:CreateDropDown(nil, SyndicateHistoricalLoots.frame, SyndicateHistoricalLoots.frame, SyndicateDB.loot, SyndicateHistoricalLoots.currentPlayer, loadLoot)
        ---------
        -- NOM --
        ---------
        SyndicateHistoricalLoots.frame.playerName = SyndicateHistoricalLoots.frame:CreateFontString('ARTWORK')
        SyndicateHistoricalLoots.frame.playerName:SetFontObject('GameFontNormal')
        SyndicateHistoricalLoots.frame.playerName:SetPoint('LEFT', SyndicateHistoricalLoots.frame.dropdown, "RIGHT", 10, 0)
        SyndicateHistoricalLoots.frame.playerName:SetText("")
        -----------
        -- CHECK --
        -----------
        SyndicateHistoricalLoots.frame.checkBis = CreateFrame("CheckButton", "SyndicateHistoricalLootCheckBis", SyndicateHistoricalLoots.frame, "UICheckButtonTemplate");
        SyndicateHistoricalLoots.frame.checkBis:SetPoint("TOPLEFT", SyndicateHistoricalLoots.frame.dropdown, "BOTTOMLEFT", 12, 0);
        _G[SyndicateHistoricalLoots.frame.checkBis:GetName().."Text"]:SetText("BIS");
        SyndicateHistoricalLoots.frame.checkBis:SetChecked(SyndicateHistoricalLoots.checkValue.showBis);
        SyndicateHistoricalLoots.frame.checkBis:SetScript("OnClick", function()
            SyndicateHistoricalLoots.checkValue.showBis = not SyndicateHistoricalLoots.checkValue.showBis;
            loadLoot(SyndicateHistoricalLoots.currentPlayer.classe, SyndicateHistoricalLoots.currentPlayer.name, SyndicateDB.loot);
        end)

        SyndicateHistoricalLoots.frame.check1 = CreateFrame("CheckButton", "SyndicateHistoricalLootCheck1", SyndicateHistoricalLoots.frame, "UICheckButtonTemplate");
        SyndicateHistoricalLoots.frame.check1:SetPoint("LEFT", SyndicateHistoricalLoots.frame.checkBis, "RIGHT", 15, 0);
        _G[SyndicateHistoricalLoots.frame.check1:GetName().."Text"]:SetText("+1");
        SyndicateHistoricalLoots.frame.check1:SetChecked(SyndicateHistoricalLoots.checkValue.show1);
        SyndicateHistoricalLoots.frame.check1:SetScript("OnClick", function()
            SyndicateHistoricalLoots.checkValue.show1 = not SyndicateHistoricalLoots.checkValue.show1;
            loadLoot(SyndicateHistoricalLoots.currentPlayer.classe, SyndicateHistoricalLoots.currentPlayer.name, SyndicateDB.loot);
        end)

        SyndicateHistoricalLoots.frame.check2 = CreateFrame("CheckButton", "SyndicateHistoricalLootCheck2", SyndicateHistoricalLoots.frame, "UICheckButtonTemplate");
        SyndicateHistoricalLoots.frame.check2:SetPoint("LEFT", SyndicateHistoricalLoots.frame.check1, "RIGHT", 15, 0);
        _G[SyndicateHistoricalLoots.frame.check2:GetName().."Text"]:SetText("+2");
        SyndicateHistoricalLoots.frame.check2:SetChecked(SyndicateHistoricalLoots.checkValue.show2);
        SyndicateHistoricalLoots.frame.check2:SetScript("OnClick", function()
            SyndicateHistoricalLoots.checkValue.show2 = not SyndicateHistoricalLoots.checkValue.show2;
            loadLoot(SyndicateHistoricalLoots.currentPlayer.classe, SyndicateHistoricalLoots.currentPlayer.name, SyndicateDB.loot);
        end)


        SyndicateHistoricalLoots.frame.bodyWrapper = SyndicateMaker:MakeWrapperWithBorder(SyndicateHistoricalLoots.frame, 0, -110, 140)
        SyndicateHistoricalLoots.frame.body = SyndicateMaker:MakeFrameWithScroll(SyndicateHistoricalLoots.frame.bodyWrapper, SyndicateHistoricalLoots.frame.bodyWrapper);
        CheckDb(SyndicateDBPlayerBis.classe, SyndicateDBPlayerBis.pseudo, SyndicateDB.loot);
    else
        if(SyndicateHistoricalLoots.frame:IsShown()) then
            SyndicateHistoricalLoots.frame:Hide();
        else
            SyndicateHistoricalLoots.frame:Show();
            CheckDb(SyndicateDBPlayerBis.classe, SyndicateDBPlayerBis.pseudo, SyndicateDB.loot);
        end
    end
end
SlashCmdList['SYNDICATEFRAME'] = function(msg)
    SyndicateHistoricalLoots:toggle()
end
SLASH_SYNDICATEFRAME1 = '/synframe'