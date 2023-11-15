----------------
-- Namespaces --
----------------
local _, core = ...;
local UtilsHistoricalLoots = core.UtilsHistoricalLoots;

local SyndicateHistoricalLoots = {}
framepool = {}
framepoolUse = {}

test = {
    paladin = {
        Badlight = {
            {idLoot=49623, attrib="+bis", date="13/11"},
            {idLoot=28041, attrib="+2", date="13/11"}
        },
        Tit = {
            {idLoot=9533, attrib="+bis", date="13/11"},
        },
        Other = {
            {idLoot=25716, attrib="+bis", date="13/11"},
            {idLoot=25598, attrib="+bis", date="13/11"},
            {idLoot=25506, attrib="+bis", date="13/11"},
        }
    }
}
testSelect = {
    classe = nil,
    pseudo = nil
}


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
        if(refFrame == nil) then
            refFrame = SyndicateHistoricalLoots:getFrame(SyndicateHistoricalLoots.frame.body.moduleoptions, true)
        else
            refFrame = SyndicateHistoricalLoots:getFrame(refFrame, false)
        end
        UtilsHistoricalLoots:SetItemFrameBis(refFrame, entries.idObjet, entries.attribution, entries.date, entries.number);
    end
end

function CheckDb(classe, pseudo, data)
    if(classe ~= nil and pseudo ~= nil and data ~= nid) then
        if(data[classe] ~= nil and data[classe][pseudo] ~= nil) then
            loadLoot(SyndicateDBPlayerBis.classe, SyndicateDBPlayerBis.pseudo, SyndicateDB.loot);
        end
    end

end

function SyndicateHistoricalLoots:toggle()
    if(SyndicateHistoricalLoots.frame == nil) then
        SyndicateHistoricalLoots.frame = SyndicateMaker:makeFrame(nil, UIParent, "Historique de loots", 400, 400);
        SyndicateHistoricalLoots.frame.dropdown = SyndicateMaker:CreateDropDown(nil, SyndicateHistoricalLoots.frame, SyndicateHistoricalLoots.frame, SyndicateDB.loot, testSelect, loadLoot)
        
        ---------
        -- NOM --
        ---------
        SyndicateHistoricalLoots.frame.playerName = SyndicateHistoricalLoots.frame:CreateFontString('ARTWORK')
        SyndicateHistoricalLoots.frame.playerName:SetFontObject('GameFontNormal')
        SyndicateHistoricalLoots.frame.playerName:SetPoint('LEFT', SyndicateHistoricalLoots.frame.dropdown, "RIGHT", 10, 0)
        SyndicateHistoricalLoots.frame.playerName:SetText("dsqd")
        
        SyndicateHistoricalLoots.frame.bodyWrapper = SyndicateMaker:MakeWrapperWithBorder(SyndicateHistoricalLoots.frame)
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