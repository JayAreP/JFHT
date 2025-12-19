local addonName, addon = ...

-- Saved variables with defaults
HealingFloatersDB = HealingFloatersDB or {
    leftAnchor = { x = -400, y = 100 },
    leftAnchor2 = { x = -400, y = -100 },
    rightAnchor = { x = 400, y = 100 },
    rightAnchor2 = { x = 400, y = -100 },
    locked = false,
    fontSize = 20,
    maxSimultaneous = 20,
    animationSpeed = 50, -- pixels per second
    animationDuration = 2, -- seconds
    directHealThreshold = 0, -- minimum heal amount to show for direct heals
    hotThreshold = 0, -- minimum heal amount to show for HoTs
}

-- Ensure new fields exist for existing saved variables
HealingFloatersDB.directHealThreshold = HealingFloatersDB.directHealThreshold or 0
HealingFloatersDB.hotThreshold = HealingFloatersDB.hotThreshold or 0

-- Create left anchor (Direct Heals)
local leftAnchor = CreateFrame("Frame", "HealingFloatersLeftAnchor", UIParent)
leftAnchor:SetSize(150, 40)
leftAnchor:SetPoint("CENTER", UIParent, "CENTER", HealingFloatersDB.leftAnchor.x, HealingFloatersDB.leftAnchor.y)
leftAnchor:SetMovable(true)
leftAnchor:EnableMouse(true)
leftAnchor:RegisterForDrag("LeftButton")
leftAnchor:SetClampedToScreen(true)

-- Left anchor background
local leftBg = leftAnchor:CreateTexture(nil, "BACKGROUND")
leftBg:SetAllPoints()
leftBg:SetColorTexture(0, 0.7, 0, 0.5)

-- Left anchor text
local leftText = leftAnchor:CreateFontString(nil, "OVERLAY", "GameFontNormal")
leftText:SetPoint("CENTER")
leftText:SetText("Direct Heals 1")

-- Create left anchor 2 (Direct Heals 2)
local leftAnchor2 = CreateFrame("Frame", "HealingFloatersLeftAnchor2", UIParent)
leftAnchor2:SetSize(150, 40)
leftAnchor2:SetPoint("CENTER", UIParent, "CENTER", HealingFloatersDB.leftAnchor2.x, HealingFloatersDB.leftAnchor2.y)
leftAnchor2:SetMovable(true)
leftAnchor2:EnableMouse(true)
leftAnchor2:RegisterForDrag("LeftButton")
leftAnchor2:SetClampedToScreen(true)

-- Left anchor 2 background
local leftBg2 = leftAnchor2:CreateTexture(nil, "BACKGROUND")
leftBg2:SetAllPoints()
leftBg2:SetColorTexture(0, 0.5, 0, 0.5)

-- Left anchor 2 text
local leftText2 = leftAnchor2:CreateFontString(nil, "OVERLAY", "GameFontNormal")
leftText2:SetPoint("CENTER")
leftText2:SetText("Direct Heals 2")

-- Create right anchor (HoTs)
local rightAnchor = CreateFrame("Frame", "HealingFloatersRightAnchor", UIParent)
rightAnchor:SetSize(150, 40)
rightAnchor:SetPoint("CENTER", UIParent, "CENTER", HealingFloatersDB.rightAnchor.x, HealingFloatersDB.rightAnchor.y)
rightAnchor:SetMovable(true)
rightAnchor:EnableMouse(true)
rightAnchor:RegisterForDrag("LeftButton")
rightAnchor:SetClampedToScreen(true)

-- Right anchor background
local rightBg = rightAnchor:CreateTexture(nil, "BACKGROUND")
rightBg:SetAllPoints()
rightBg:SetColorTexture(0.7, 0.7, 0, 0.5)

-- Right anchor text
local rightText = rightAnchor:CreateFontString(nil, "OVERLAY", "GameFontNormal")
rightText:SetPoint("CENTER")
rightText:SetText("HoTs 1")

-- Create right anchor 2 (HoTs 2)
local rightAnchor2 = CreateFrame("Frame", "HealingFloatersRightAnchor2", UIParent)
rightAnchor2:SetSize(150, 40)
rightAnchor2:SetPoint("CENTER", UIParent, "CENTER", HealingFloatersDB.rightAnchor2.x, HealingFloatersDB.rightAnchor2.y)
rightAnchor2:SetMovable(true)
rightAnchor2:EnableMouse(true)
rightAnchor2:RegisterForDrag("LeftButton")
rightAnchor2:SetClampedToScreen(true)

-- Right anchor 2 background
local rightBg2 = rightAnchor2:CreateTexture(nil, "BACKGROUND")
rightBg2:SetAllPoints()
rightBg2:SetColorTexture(0.5, 0.5, 0, 0.5)

-- Right anchor 2 text
local rightText2 = rightAnchor2:CreateFontString(nil, "OVERLAY", "GameFontNormal")
rightText2:SetPoint("CENTER")
rightText2:SetText("HoTs 2")

-- Function to update anchor visibility
local function UpdateAnchorVisibility()
    if HealingFloatersDB.locked then
        leftAnchor:Hide()
        leftAnchor2:Hide()
        rightAnchor:Hide()
        rightAnchor2:Hide()
    else
        leftAnchor:Show()
        leftAnchor2:Show()
        rightAnchor:Show()
        rightAnchor2:Show()
    end
end

-- Drag functionality for left anchor
leftAnchor:SetScript("OnDragStart", function(self)
    if not HealingFloatersDB.locked then
        self:StartMoving()
    end
end)
leftAnchor:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local point, _, _, x, y = self:GetPoint()
    HealingFloatersDB.leftAnchor.x = x
    HealingFloatersDB.leftAnchor.y = y
end)

-- Drag functionality for left anchor 2
leftAnchor2:SetScript("OnDragStart", function(self)
    if not HealingFloatersDB.locked then
        self:StartMoving()
    end
end)
leftAnchor2:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local point, _, _, x, y = self:GetPoint()
    HealingFloatersDB.leftAnchor2.x = x
    HealingFloatersDB.leftAnchor2.y = y
end)

-- Drag functionality for right anchor
rightAnchor:SetScript("OnDragStart", function(self)
    if not HealingFloatersDB.locked then
        self:StartMoving()
    end
end)
rightAnchor:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local point, _, _, x, y = self:GetPoint()
    HealingFloatersDB.rightAnchor.x = x
    HealingFloatersDB.rightAnchor.y = y
end)

-- Drag functionality for right anchor 2
rightAnchor2:SetScript("OnDragStart", function(self)
    if not HealingFloatersDB.locked then
        self:StartMoving()
    end
end)
rightAnchor2:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local point, _, _, x, y = self:GetPoint()
    HealingFloatersDB.rightAnchor2.x = x
    HealingFloatersDB.rightAnchor2.y = y
end)

-- Create configuration window
local configFrame = CreateFrame("Frame", "HealingFloatersConfig", UIParent, "BasicFrameTemplateWithInset")
configFrame:SetSize(400, 350)
configFrame:SetPoint("CENTER")
configFrame:SetMovable(true)
configFrame:EnableMouse(true)
configFrame:RegisterForDrag("LeftButton")
configFrame:SetScript("OnDragStart", configFrame.StartMoving)
configFrame:SetScript("OnDragStop", configFrame.StopMovingOrSizing)
configFrame:Hide()

configFrame.title = configFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
configFrame.title:SetPoint("TOP", configFrame, "TOP", 0, -5)
configFrame.title:SetText("Jar's Floating Healing Text Configuration")

-- Lock/Unlock checkbox
local lockCheckbox = CreateFrame("CheckButton", nil, configFrame, "UICheckButtonTemplate")
lockCheckbox:SetPoint("TOPLEFT", configFrame, "TOPLEFT", 20, -40)
lockCheckbox.text = lockCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
lockCheckbox.text:SetPoint("LEFT", lockCheckbox, "RIGHT", 5, 0)
lockCheckbox.text:SetText("Lock Anchors")
lockCheckbox:SetChecked(HealingFloatersDB.locked)
lockCheckbox:SetScript("OnClick", function(self)
    HealingFloatersDB.locked = self:GetChecked()
    UpdateAnchorVisibility()
end)

-- Max Simultaneous slider
local maxSimLabel = configFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
maxSimLabel:SetPoint("TOPLEFT", lockCheckbox, "BOTTOMLEFT", 0, -20)
maxSimLabel:SetText("Max Simultaneous Heals: " .. HealingFloatersDB.maxSimultaneous)

local maxSimSlider = CreateFrame("Slider", nil, configFrame, "OptionsSliderTemplate")
maxSimSlider:SetPoint("TOPLEFT", maxSimLabel, "BOTTOMLEFT", 5, -10)
maxSimSlider:SetMinMaxValues(5, 50)
maxSimSlider:SetValue(HealingFloatersDB.maxSimultaneous)
maxSimSlider:SetValueStep(1)
maxSimSlider:SetObeyStepOnDrag(true)
maxSimSlider:SetWidth(300)
maxSimSlider.Low:SetText("5")
maxSimSlider.High:SetText("50")
maxSimSlider:SetScript("OnValueChanged", function(self, value)
    HealingFloatersDB.maxSimultaneous = math.floor(value)
    maxSimLabel:SetText("Max Simultaneous Heals: " .. HealingFloatersDB.maxSimultaneous)
end)

-- Animation Speed slider
local speedLabel = configFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
speedLabel:SetPoint("TOPLEFT", maxSimSlider, "BOTTOMLEFT", -5, -20)
speedLabel:SetText("Animation Speed: " .. HealingFloatersDB.animationSpeed .. " pixels/sec")

local speedSlider = CreateFrame("Slider", nil, configFrame, "OptionsSliderTemplate")
speedSlider:SetPoint("TOPLEFT", speedLabel, "BOTTOMLEFT", 5, -10)
speedSlider:SetMinMaxValues(20, 150)
speedSlider:SetValue(HealingFloatersDB.animationSpeed)
speedSlider:SetValueStep(5)
speedSlider:SetObeyStepOnDrag(true)
speedSlider:SetWidth(300)
speedSlider.Low:SetText("Slow")
speedSlider.High:SetText("Fast")
speedSlider:SetScript("OnValueChanged", function(self, value)
    HealingFloatersDB.animationSpeed = math.floor(value)
    speedLabel:SetText("Animation Speed: " .. HealingFloatersDB.animationSpeed .. " pixels/sec")
end)

-- Animation Duration slider
local durationLabel = configFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
durationLabel:SetPoint("TOPLEFT", speedSlider, "BOTTOMLEFT", -5, -20)
durationLabel:SetText("Animation Duration: " .. HealingFloatersDB.animationDuration .. " seconds")

local durationSlider = CreateFrame("Slider", nil, configFrame, "OptionsSliderTemplate")
durationSlider:SetPoint("TOPLEFT", durationLabel, "BOTTOMLEFT", 5, -10)
durationSlider:SetMinMaxValues(1, 5)
durationSlider:SetValue(HealingFloatersDB.animationDuration)
durationSlider:SetValueStep(0.5)
durationSlider:SetObeyStepOnDrag(true)
durationSlider:SetWidth(300)
durationSlider.Low:SetText("1s")
durationSlider.High:SetText("5s")
durationSlider:SetScript("OnValueChanged", function(self, value)
    HealingFloatersDB.animationDuration = value
    durationLabel:SetText("Animation Duration: " .. HealingFloatersDB.animationDuration .. " seconds")
end)

-- Direct Heal Threshold input
local directThresholdLabel = configFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
directThresholdLabel:SetPoint("TOPLEFT", durationSlider, "BOTTOMLEFT", -5, -25)
directThresholdLabel:SetText("Direct Heal Threshold:")

local directThresholdBox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
directThresholdBox:SetPoint("LEFT", directThresholdLabel, "RIGHT", 10, 0)
directThresholdBox:SetSize(100, 30)
directThresholdBox:SetAutoFocus(false)
directThresholdBox:SetText(tostring(HealingFloatersDB.directHealThreshold))
directThresholdBox:SetScript("OnEnterPressed", function(self)
    local value = tonumber(self:GetText()) or 0
    if value < 0 then value = 0 end
    HealingFloatersDB.directHealThreshold = math.floor(value)
    self:SetText(tostring(HealingFloatersDB.directHealThreshold))
    self:ClearFocus()
end)
directThresholdBox:SetScript("OnEscapePressed", function(self)
    self:SetText(tostring(HealingFloatersDB.directHealThreshold))
    self:ClearFocus()
end)

-- HoT Threshold input
local hotThresholdLabel = configFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
hotThresholdLabel:SetPoint("TOPLEFT", directThresholdLabel, "BOTTOMLEFT", 0, -15)
hotThresholdLabel:SetText("HoT Threshold:")

local hotThresholdBox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
hotThresholdBox:SetPoint("LEFT", hotThresholdLabel, "RIGHT", 10, 0)
hotThresholdBox:SetSize(100, 30)
hotThresholdBox:SetAutoFocus(false)
hotThresholdBox:SetText(tostring(HealingFloatersDB.hotThreshold))
hotThresholdBox:SetScript("OnEnterPressed", function(self)
    local value = tonumber(self:GetText()) or 0
    if value < 0 then value = 0 end
    HealingFloatersDB.hotThreshold = math.floor(value)
    self:SetText(tostring(HealingFloatersDB.hotThreshold))
    self:ClearFocus()
end)
hotThresholdBox:SetScript("OnEscapePressed", function(self)
    self:SetText(tostring(HealingFloatersDB.hotThreshold))
    self:ClearFocus()
end)

-- Pool for text frames to reuse
local textFramePool = {}

-- Track active frames per anchor to avoid overlaps
local activeFrames = {
    left1 = {},
    left2 = {},
    right1 = {},
    right2 = {}
}

-- Function to get or create a floating text frame
local function GetTextFrame(anchorFrame, anchorType)
    local frame
    if #textFramePool > 0 then
        frame = table.remove(textFramePool)
    else
        frame = CreateFrame("Frame", nil, UIParent)
        
        -- Create icon texture
        frame.icon = frame:CreateTexture(nil, "OVERLAY")
        frame.icon:SetPoint("RIGHT", frame, "CENTER", -2, 0)
        
        -- Create text
        frame.text = frame:CreateFontString(nil, "OVERLAY")
        frame.text:SetPoint("LEFT", frame, "CENTER", 2, 0)
    end
    
    -- Update font and icon size each time (in case fontSize changed)
    local defaultFont = GameFontNormal:GetFont()
    frame.text:SetFont(defaultFont, HealingFloatersDB.fontSize, "OUTLINE")
    frame.icon:SetSize(HealingFloatersDB.fontSize, HealingFloatersDB.fontSize)
    
    -- Calculate Y offset to avoid overlaps
    local yOffset = 0
    local frameHeight = HealingFloatersDB.fontSize + 5
    local activeList = activeFrames[anchorType]
    
    -- Find an available slot
    for i = 1, HealingFloatersDB.maxSimultaneous do
        local slotTaken = false
        for _, activeFrame in ipairs(activeList) do
            if activeFrame.slotIndex == i then
                slotTaken = true
                break
            end
        end
        if not slotTaken then
            frame.slotIndex = i
            yOffset = (i - 1) * frameHeight
            break
        end
    end
    
    frame:SetSize(200, 30)
    frame:SetPoint("CENTER", anchorFrame, "CENTER", math.random(-20, 20), yOffset)
    frame:SetAlpha(1)
    frame:Show()
    
    -- Add to active list
    table.insert(activeList, frame)
    frame.anchorType = anchorType
    
    return frame
end

-- Function to release text frame back to pool
local function ReleaseTextFrame(frame)
    frame:Hide()
    frame:SetScript("OnUpdate", nil)
    
    -- Remove from active list
    if frame.anchorType then
        local activeList = activeFrames[frame.anchorType]
        for i, activeFrame in ipairs(activeList) do
            if activeFrame == frame then
                table.remove(activeList, i)
                break
            end
        end
    end
    
    frame.slotIndex = nil
    frame.anchorType = nil
    table.insert(textFramePool, frame)
end

-- Function to format numbers
local function FormatNumber(num)
    if num >= 1000000 then
        return string.format("%.1fM", num / 1000000)
    elseif num >= 1000 then
        return string.format("%.1fK", num / 1000)
    else
        return tostring(math.floor(num))
    end
end

-- Function to create floating text
local function CreateFloatingText(anchorFrame, amount, isCrit, spellId)
    local anchorType
    if anchorFrame == leftAnchor then
        anchorType = "left1"
    elseif anchorFrame == leftAnchor2 then
        anchorType = "left2"
    elseif anchorFrame == rightAnchor then
        anchorType = "right1"
    else
        anchorType = "right2"
    end
    local frame = GetTextFrame(anchorFrame, anchorType)
    local formattedAmount = FormatNumber(amount)
    
    -- Set spell icon
    local iconTexture = C_Spell.GetSpellTexture(spellId)
    if iconTexture then
        frame.icon:SetTexture(iconTexture)
        frame.icon:Show()
    else
        frame.icon:Hide()
    end
    
    -- Color and style based on crit
    if isCrit then
        frame.text:SetText(formattedAmount .. "!")
        frame.text:SetTextColor(1, 1, 0.3, 1) -- Bright yellow for crits
    else
        frame.text:SetText(formattedAmount)
        frame.text:SetTextColor(0.3, 1, 0.3, 1) -- Green for normal heals
    end
    
    -- Animation
    local elapsed = 0
    local duration = HealingFloatersDB.animationDuration
    local distance = HealingFloatersDB.animationSpeed * duration
    local startX, startY = frame:GetCenter()
    
    frame:SetScript("OnUpdate", function(self, delta)
        elapsed = elapsed + delta
        
        if elapsed >= duration then
            ReleaseTextFrame(frame)
            return
        end
        
        -- Calculate position and alpha
        local progress = elapsed / duration
        local newY = startY + (distance * progress)
        
        -- Ease out alpha (fade out near the end)
        local alpha = 1 - (progress * progress)
        
        frame:ClearAllPoints()
        frame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", startX, newY)
        frame:SetAlpha(alpha)
    end)
end

-- Event handler
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
eventFrame:RegisterEvent("PLAYER_LOGIN")

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        print("|cff00ff00Jar's Floating Healing Text|r loaded. Type /jfht for options.")
        UpdateAnchorVisibility()
        
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, _, destGUID, destName, destFlags, _, 
              spellId, spellName, spellSchool, amount, overhealing, absorbed, critical = CombatLogGetCurrentEventInfo()
        
        -- Check if the source is the player
        if sourceGUID == UnitGUID("player") then
            -- Check for healing events
            if subevent == "SPELL_HEAL" or subevent == "SPELL_PERIODIC_HEAL" then
                if amount and amount > 0 then
                    -- Split by odd/even spell IDs
                    local isOdd = (spellId % 2) == 1
                    
                    -- SPELL_PERIODIC_HEAL = HoT ticks (right anchors)
                    -- SPELL_HEAL = Direct heals (left anchors)
                    if subevent == "SPELL_PERIODIC_HEAL" then
                        -- Check HoT threshold
                        local threshold = HealingFloatersDB.hotThreshold or 0
                        if amount >= threshold then
                            if isOdd then
                                CreateFloatingText(rightAnchor, amount, critical, spellId)
                            else
                                CreateFloatingText(rightAnchor2, amount, critical, spellId)
                            end
                        end
                    else
                        -- Check direct heal threshold
                        local threshold = HealingFloatersDB.directHealThreshold or 0
                        if amount >= threshold then
                            if isOdd then
                                CreateFloatingText(leftAnchor, amount, critical, spellId)
                            else
                                CreateFloatingText(leftAnchor2, amount, critical, spellId)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Slash commands
SLASH_HEALINGFLOATERS1 = "/jfht"
SlashCmdList["HEALINGFLOATERS"] = function(msg)
    msg = string.lower(msg)
    
    if msg == "config" or msg == "" then
        configFrame:SetShown(not configFrame:IsShown())
    elseif msg == "lock" then
        HealingFloatersDB.locked = true
        UpdateAnchorVisibility()
        print("|cff00ff00Jar's Floating Healing Text|r: Anchors locked")
    elseif msg == "unlock" then
        HealingFloatersDB.locked = false
        UpdateAnchorVisibility()
        print("|cff00ff00Jar's Floating Healing Text|r: Anchors unlocked (drag to move)")
    elseif msg == "reset" then
        HealingFloatersDB.leftAnchor = { x = -400, y = 100 }
        HealingFloatersDB.leftAnchor2 = { x = -400, y = -100 }
        HealingFloatersDB.rightAnchor = { x = 400, y = 100 }
        HealingFloatersDB.rightAnchor2 = { x = 400, y = -100 }
        leftAnchor:ClearAllPoints()
        leftAnchor2:ClearAllPoints()
        rightAnchor:ClearAllPoints()
        rightAnchor2:ClearAllPoints()
        leftAnchor:SetPoint("CENTER", UIParent, "CENTER", -400, 100)
        leftAnchor2:SetPoint("CENTER", UIParent, "CENTER", -400, -100)
        rightAnchor:SetPoint("CENTER", UIParent, "CENTER", 400, 100)
        rightAnchor2:SetPoint("CENTER", UIParent, "CENTER", 400, -100)
        print("|cff00ff00Jar's Floating Healing Text|r: Anchor positions reset")
    elseif msg == "test" then
        -- Create test healing text (odd/even spell IDs)
        CreateFloatingText(leftAnchor, 5234, false, 2061) -- Odd spell ID - Direct Heals 1
        CreateFloatingText(leftAnchor2, 12456, true, 2060) -- Even spell ID - Direct Heals 2
        CreateFloatingText(rightAnchor, 2341, false, 139) -- Odd spell ID - HoTs 1
        CreateFloatingText(rightAnchor2, 8967, true, 774) -- Even spell ID - HoTs 2
        print("|cff00ff00Jar's Floating Healing Text|r: Test text created")
    elseif msg == "help" then
        print("|cff00ff00Jar's Floating Healing Text|r Commands:")
        print("  /jfht config - Toggle configuration window")
        print("  /jfht lock - Lock anchors in place")
        print("  /jfht unlock - Unlock anchors (drag to move)")
        print("  /jfht reset - Reset anchor positions")
        print("  /jfht test - Show test healing text")
        print("  /jfht help - Show this help")
    else
        print("|cff00ff00Jar's Floating Healing Text|r: Unknown command. Type /jfht help for options.")
    end
end
