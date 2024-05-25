local backdropInfo =
{
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
 	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
 	tile = true,
 	tileEdge = true,
 	tileSize = 8,
 	edgeSize = 8,
 	insets = { left = 1, right = 1, top = 1, bottom = 1 },
}


local frame = CreateFrame("Frame", "HealthManaFrame", UIParent, "BackdropTemplate")
frame:SetSize(200, 100)
frame:SetPoint("CENTER", 0, 100)
frame:SetBackdrop(backdropInfo)
frame:SetBackdropColor(0, 0, 0, .5)


local titleText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
titleText:SetFont("Fonts\\FRIZQT__.TTF", 20)
titleText:SetPoint("TOP", 0, -100)
titleText:SetText("Nephbar")

local healthText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
healthText:SetFont("Fonts\\FRIZQT__.TTF", 20)
healthText:SetPoint("TOPLEFT", 15, -10)
healthText:SetJustifyH("LEFT")

local manaText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
manaText:SetFont("Fonts\\FRIZQT__.TTF", 20)
manaText:SetPoint("TOPLEFT", healthText, "BOTTOMLEFT", 0, -10)
manaText:SetJustifyH("LEFT")


local function UpdateHealthMana()
    local health = UnitHealth("player")
    local maxHealth = UnitHealthMax("player")
    local mana = UnitPower("player", Enum.PowerType.Mana)
    local maxMana = UnitPowerMax("player", Enum.PowerType.Mana)

    local healthPercent = (health / maxHealth) * 100
    local healthColor
    if healthPercent > 75 then
        healthColor = "|cFF00FF00"
    elseif healthPercent > 25 then
        healthColor = "|cFFFFFF00"
    else
        healthColor = "|cFFFF0000"
    end

    healthText:SetText(healthColor .. "Health: " .. health .. " / " .. maxHealth .. "|r")

    manaText:SetText("|cFF0000FF" .. "Mana: " .. mana .. " / " .. maxMana .. "|r")
end

frame:RegisterEvent("UNIT_HEALTH")
frame:RegisterEvent("UNIT_MAXHEALTH")
frame:RegisterEvent("UNIT_POWER_UPDATE")
frame:RegisterEvent("UNIT_MAXPOWER")

frame:SetScript("OnEvent", function(self, event, arg1)
    if arg1 == "player" then
        UpdateHealthMana()
    end
end)

UpdateHealthMana()
