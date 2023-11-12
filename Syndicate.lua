local main_frame = nil
local frame = nil
local items = {}

Syndicate = LibStub("AceAddon-3.0"):NewAddon("Syndicate", "AceConsole-3.0")
local syndicateLDB = LibStub("LibDataBroker-1.1"):NewDataObject("Syndicate", {
    type = "data source",
    text = "Syndicate",
    icon = "Interface\\AddOns\\Syndicate\\Media\\iconOpen.tga",
    OnClick = function(_, button)
        if button == "LeftButton" then
            SynBis:Toggle();
        end
        if button == "RightButton" then
            SynImport:Toggle();
        end
         
     end,
    OnTooltipShow = function(tt)
        tt:AddLine("Syndicate Addon")
        tt:AddLine("|cffffff00 Clic Gauche - Voir les bislist")
        tt:AddLine("|cffffff00 Clic Droit - Importer les data des bislist")
        tt:AddLine("|cffffff00 Slash Cmd - /syninit")
    end,
    })
local iconMap = LibStub("LibDBIcon-1.0")




function Syndicate:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("SyndicateDB",
    { profile =
        { minimap = 
            { hide = false, }, 
        },
    }) 
    iconMap:Register("Syndicate", syndicateLDB, self.db.profile.minimap)
    self:RegisterChatCommand("Syndicate", "CommandeSyndicate")
end

function Syndicate:CommandeSyndicate()
    self.db.profile.minimap.hide = not
    self.db.profile.minimap.hide if self.db.profile.minimap.hide
    then iconMap:Hide("Syndicate!")
    else iconMap:Show("Syndicate!")
    end
end
