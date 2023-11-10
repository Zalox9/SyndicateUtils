local function copyDefaults(src, dst)
    -- If no source (defaults) is specified, return an empty table:
    if type(src) ~= "table" then return {} end
    -- If no target (saved variable) is specified, create a new table:
    if not type(dst) then dst = {} end
    -- Loop through the source (defaults):
    for k, v in pairs(src) do
        -- If the value is a sub-table:
        if type(v) == "table" then
            -- Recursively call the function:
            dst[k] = copyDefaults(v, dst[k])
        -- Or if the default value type doesn't match the existing value type:
        elseif type(v) ~= type(dst[k]) then
            -- Overwrite the existing value with the default one:
            dst[k] = v
        end
    end
    -- Return the destination table:
    return dst
end

SyndicateDB = copyDefaults(SyndicateDB, SyndicateDB)
SyndicateDBPlayerBis = copyDefaults(SyndicateDBPlayerBis, SyndicateDBPlayerBis)
