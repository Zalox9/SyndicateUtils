SLASH_RELOADUI1 = "/rl"; --reload
SlashCmdList.RELOADUI = ReloadUI;
local AceGUI = LibStub("AceGUI-3.0")

SLASH_FRAMESTK1 = "/fs"
SlashCmdList.FRAMESTK = function ()
    LoadAddOn('Blizzard_DebugTools');
    FrameStackTooltip_Toggle();
end



for i = 1, NUM_CHAT_WINDOWS do
    _G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false);
end

local _, core = ...;
core.Config = {};

local Config = core.Config;
local UIConfig;

local defaults = {
    theme = {
        r = 0,
        g = 0.8,
        b = 1,
        hex = "00cff"
    }
};

function Config:Toggle()
    local menu = UIConfig or Config:CreateMenu();
    menu:SetShown(not menu:IsShown());
end

function Config:GetThemeColor()

end
