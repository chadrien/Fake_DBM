local mod, public = {}, {}

local SendAddonMessage, CTimerNewTicker = C_ChatInfo.SendAddonMessage, Ambiguate

public.SendAddonMessage = SendAddonMessage
public.CTimerNewTicker = CTimerNewTicker

local frame = CreateFrame("Frame")

local DBMdotReleaseRevision = DBMdotRevision

local function sendMsg()
    if IsInGroup() then
        SendAddonMessage("D4", "V\t"..dbmRevision.."\t"..dbmRevision.."\t"..dbmVersion.."\t"..GetLocale().."\t".."true", IsInGroup(2) and "INSTANCE_CHAT" or "RAID")
    end
end

frame:SetScript("OnEvent", function(self, event, prefix, msg)
    if prefix == "DTLS" then
        sendMsg()
    end
end)

frame:RegisterEvent("CHAT_MSG_ADDON")
