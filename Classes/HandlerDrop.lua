---@type GL
local _, GL = ...;

---@class HandlerDrop
GL.HandlerDrop = {
    _initialized = false,
    tracking = false,
    minimumQuality = nil,
    trackItems = false,
    ProcessedNPCIDs = {},
    BroadcastedNPCIDs = {},
    KilledBosses = {},
    Dropped = {},
    Received = {},
};

---@type HandlerDrop
local HandlerDrop = GL.HandlerDrop;

---@return void
function HandlerDrop:_init()
    GL:debug("HandlerDrop:_init");

    if (self._initialized) then
        return;
    end

    self._initialized = true;
    self.minimumQuality = Settings:get("DroppedLoot.minimumQualityOfLoggedLoot", 4);

    Events:register({
            {"DroppedLootGroupRosterUpdateThrottled", "GL.GROUP_ROSTER_UPDATE_THROTTLED"},
            {"DroppedLootSettingChanged", "GL.SETTING_CHANGED"},
        },
        function ()
            self:startOrStopTracking();
        end
    );
end

--- Start or stop tracking loot based on group and add-on settings
---
---@return void
function HandlerDrop:startOrStopTracking()
    GL:debug("HandlerDrop:startOrStopTracking");

    self.trackItems = self:_shouldTrackItems();
    if (not self.trackItems) then
        self:stopTracking();
    else
        self:startTracking();
    end
end


---@return void
function HandlerDrop:startTracking()
    GL:debug("HandlerDrop:startTracking");

    if (self.tracking) then
        return;
    end

    self.tracking = true;

    -- Just in case the event listeners already exist we remove them
    Events:unregister{
        "HandlerDropChatMSGLootListener",
        "HandlerDropLootReadyListener",
        "HandlerDropCombatLogEventUnfilteredListener",
    };

    -- Item received message detected in chat
    Events:register("HandlerDropChatMSGLootListener", "CHAT_MSG_LOOT", function(_, message)
        self:processReceivedItem(message);
    end);

    -- Loot window opened
    --Events:register("HandlerDropLootReadyListener", "LOOT_OPENED", function()
    --    self:lootOpened();
    --end);

    -- Check if a unit was killed
    --Events:register("HandlerDropCombatLogEventUnfilteredListener", "COMBAT_LOG_EVENT_UNFILTERED", function()
    --    self:processCombatLog(CombatLogGetCurrentEventInfo());
    --end);
end

---@return void
function HandlerDrop:stopTracking()
    GL:debug("HandlerDrop:stopTracking");

    Events:unregister{
        "HandlerDropChatMSGLootListener",
        "HandlerDropLootReadyListener",
        "HandlerDropCombatLogEventUnfilteredListener",
    };

    self.tracking = false;
end