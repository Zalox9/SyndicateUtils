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
    local x, y = 20, -10
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

function SyndicateHistoricalLoots:toggle()
    if(SyndicateHistoricalLoots.frame == nil) then
        SyndicateHistoricalLoots.frame = SyndicateMaker:makeFrame(nil, UIParent, "Historique de loots", 400, 400);
        SyndicateHistoricalLoots.frame.dropdown = SyndicateMaker:CreateDropDown(nil, SyndicateHistoricalLoots.frame, SyndicateHistoricalLoots.frame, SyndicateDB.loot, testSelect, loadLoot)
        SyndicateHistoricalLoots.frame.body = SyndicateMaker:MakeFrameWithScroll(SyndicateHistoricalLoots.frame, SyndicateHistoricalLoots.frame);
    else
        if(SyndicateHistoricalLoots.frame:IsShown()) then
            SyndicateHistoricalLoots.frame:Hide();
        else
            SyndicateHistoricalLoots.frame:Show();
        end
    end
end
SlashCmdList['SYNDICATEFRAME'] = function(msg)
    SyndicateHistoricalLoots:toggle()
end
SLASH_SYNDICATEFRAME1 = '/synframe'