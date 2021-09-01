local ADDON_NAME, ns = ...
local oUF = ns.oUF

local AddOn = LibStub("AceAddon-3.0"):NewAddon(ADDON_NAME)
--AddOn.L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)
AddOn.defaults = {
  global = {},
  profile = {
    useClassColors = true,
    displaySelectionHighlight = true,
    displayAggroHighlight = true,
    displayName = true,
    fadeOutOfRange = true,
    displayStatusText = true,
    displayHealPrediction = true,
    displayRoleIcon = true,
    displayRaidRoleIcon = true,
    displayDispelDebuffs = true,
    displayBuffs = true,
    displayDebuffs = true,
    displayOnlyDispellableDebuffs = false,
    displayNonBossDebuffs = true,
    healthText = "none",
    displayIncomingResurrect = true,
    displayIncomingSummon = true,
    displayInOtherGroup = true,
    displayInOtherPhase = true,

    --If class colors are enabled also show the class colors for npcs in your raid frames or
    --raid-frame-style party frames.
    allowClassColorsForNPCs = true,

    keepGroupsTogether = false,
    sortBy = "role",
    horizontalGroups = false,
    displayPowerBar = true,
    displayPets = false,
    displayMainTankAndAssist = false,
    displayBorder = false,
    offsetX = 0,
    offsetY = 0,
    height = 180,
    width = 360,
    displayPartyGroup = false,

    colorHealthWithExtendedColors = true,
    smoothUpdates = true,
    --smoothHealthUpdates
    --displayNameWhenSelected = true,
    --displayNameByPlayerNameRules = true,
    --healthBarColorOverride = CreateColor(0, 1, 0),
  }
}

ns[1] = AddOn
--ns[2] = AddOn.L
ns[2] = AddOn.defaults.profile
ns[3] = AddOn.defaults.global

local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

RaidFrames = ns

local function GetOptions()
  if not AddOn.options then
    AddOn.options = {
      type = "group",
      childGroups = "tab",
      args = {
        general = {
          name = COMPACT_UNIT_FRAME_PROFILE_SUBTYPE_ALL,
          type = "group",
          args = {
            keepGroupsTogether = {
              name = COMPACT_UNIT_FRAME_PROFILE_KEEPGROUPSTOGETHER,
              type = "toggle",
              order = 1,
              disabled = true,
              set = function(info, value)
                AddOn.db.profile.keepGroupsTogether = value
              end,
              get = function(info)
                return AddOn.db.profile.keepGroupsTogether
              end
            },
            sortBy = {
              name = COMPACT_UNIT_FRAME_PROFILE_SORTBY,
              type = "select",
              order = 3,
              hidden = AddOn.db.profile.keepGroupsTogether,
              values = {
                ["role"] = COMPACT_UNIT_FRAME_PROFILE_SORTBY_ROLE,
                ["group"] = COMPACT_UNIT_FRAME_PROFILE_SORTBY_GROUP,
                ["alphabetical"] = COMPACT_UNIT_FRAME_PROFILE_SORTBY_ALPHABETICAL
              },
              sorting = { "role", "group", "alphabetical" },
              set = function(info, value)
                AddOn.db.profile.sortBy = value
              end,
              get = function(info)
                return AddOn.db.profile.sortBy
              end
            },
            lb3 = {
              name = "", order = 3, type =  "description",
            },
            lb4 = {
              name = "", order = 4, type = "description",
            },
            horizontalGroups = {
              name = COMPACT_UNIT_FRAME_PROFILE_HORIZONTALGROUPS,
              type = "toggle",
              order = 5,
              disabled = true,
              hidden = not AddOn.db.profile.keepGroupsTogether,
              set = function(info, value)
                AddOn.db.profile.horizontalGroups = value
              end,
              get = function(info)
                return AddOn.db.profile.horizontalGroups
              end
            },
            lb5 = {
              name = "", order = 6, type = "description",
            },
            lb6 = {
              name = "", order = 7, type = "description",
            },
            displayHealPrediction = {
              name = COMPACT_UNIT_FRAME_PROFILE_DISPLAYHEALPREDICTION,
              type = "toggle",
              order = 8,
              set = function(info, value)
                AddOn.db.profile.displayHealPrediction = value
              end,
              get = function(info)
                return AddOn.db.profile.displayHealPrediction
              end
            },
            lb7 = {
              name = "", order = 9, type = "description",
            },
            lb8 = {
              name = "", order = 10, type = "description",
            },
            displayPowerBar = {
              name = COMPACT_UNIT_FRAME_PROFILE_DISPLAYPOWERBAR,
              type = "toggle",
              order = 11,
              set = function(info, value)
                AddOn.db.profile.displayPowerBar = value
              end,
              get = function(info)
                return AddOn.db.profile.displayPowerBar
              end
            },
            lb9 = {
              name = "", order = 12, type = "description",
            },
            lb10 = {
              name = "", order = 13, type = "description",
            },
            displayAggroHighlight = {
              name = COMPACT_UNIT_FRAME_PROFILE_DISPLAYAGGROHIGHLIGHT,
              type = "toggle",
              order = 14,
              set = function(info, value)
                AddOn.db.profile.displayAggroHighlight = value
              end,
              get = function(info)
                return AddOn.db.profile.displayAggroHighlight
              end
            },
            lb11 = {
              name = "", order = 15, type = "description",
            },
            lb12 = {
              name = "", order = 16, type = "description",
            },
            useClassColors = {
              name = COMPACT_UNIT_FRAME_PROFILE_USECLASSCOLORS,
              type = "toggle",
              order = 17,
              set = function(info, value)
                AddOn.db.profile.useClassColors = value
              end,
              get = function(info)
                return AddOn.db.profile.useClassColors
              end
            },
            lb13 = {
              name = "", order = 18, type = "description",
            },
            lb14 = {
              name = "", order = 19, type = "description",
            },
            displayPets = {
              name = COMPACT_UNIT_FRAME_PROFILE_DISPLAYPETS,
              type = "toggle",
              order = 20,
              disabled = true,
              set = function(info, value)
                AddOn.db.profile.displayPets = value
              end,
              get = function(info)
                return AddOn.db.profile.displayPets
              end
            },
            lb15 = {
              name = "", order = 21, type = "description",
            },
            lb16 = {
              name = "", order = 22, type = "description",
            },
            displayMainTankAndAssist = {
              name = COMPACT_UNIT_FRAME_PROFILE_DISPLAYMAINTANKANDASSIST,
              type = "toggle",
              order = 23,
              disabled = true,
              set = function(info, value)
                AddOn.db.profile.displayMainTankAndAssist = value
              end,
              get = function(info)
                return AddOn.db.profile.displayMainTankAndAssist
              end
            },
            lb17 = {
              name = "", order = 24, type = "description",
            },
            lb18 = {
              name = "", order = 25, type = "description",
            },
            displayBorder = {
              name = COMPACT_UNIT_FRAME_PROFILE_DISPLAYBORDER,
              type = "toggle",
              order = 26,
              set = function(info, value)
                AddOn.db.profile.displayBorder = value
              end,
              get = function(info)
                return AddOn.db.profile.displayBorder
              end
            },
            lb19 = {
              name = "", order = 27, type = "description",
            },
            lb20 = {
              name = "", order = 28, type = "description",
            },
            displayDebuffs = {
              name = COMPACT_UNIT_FRAME_PROFILE_DISPLAYNONBOSSDEBUFFS,
              type = "toggle",
              order= 29,
              set = function(info, value)
                AddOn.db.profile.displayDebuffs = value
              end,
              get = function(info)
                return AddOn.db.profile.displayDebuffs
              end
            },
            lb21 = {
              name = "", order = 30, type = "description",
            },
            lb22 = {
              name = "", order = 31, type = "description",
            },
            displayOnlyDispellableDebuffs = {
              name = COMPACT_UNIT_FRAME_PROFILE_DISPLAYONLYDISPELLABLEDEBUFFS,
              type = "toggle",
              order= 32,
              set = function(info, value)
                AddOn.db.profile.displayOnlyDispellableDebuffs = value
              end,
              get = function(info)
                return AddOn.db.profile.displayOnlyDispellableDebuffs
              end
            },
            lb23 = {
              name = "", order = 33, type = "description",
            },
            lb24 = {
              name = "", order = 34, type = "description",
            },
            healthText = {
              name = COMPACT_UNIT_FRAME_PROFILE_HEALTHTEXT,
              type = "select",
              order = 35,
              values = {
                ["none"] = COMPACT_UNIT_FRAME_PROFILE_HEALTHTEXT_NONE,
                ["health"] = COMPACT_UNIT_FRAME_PROFILE_HEALTHTEXT_HEALTH,
                ["losthealth"] = COMPACT_UNIT_FRAME_PROFILE_HEALTHTEXT_LOSTHEALTH,
                ["perc"] = COMPACT_UNIT_FRAME_PROFILE_HEALTHTEXT_PERC
              },
              sorting = { "none", "health", "losthealth", "perc" },
              set = function(info, value)
                AddOn.db.profile.healthText = value
                for _, header in pairs(AddOn.headers) do
                  for i = 1, #header do
                    local frame = header[i]
                    AddOn:SetOptionTable(frame, AddOn.db.profile)
                    AddOn:UpdateStatusText(frame)
                  end
                end
              end,
              get = function(info)
                return AddOn.db.profile.healthText
              end
            },
            lb25 = {
              name = "", order = 36, type = "description",
            },
            lb26 = {
              name = "", order = 37, type = "description",
            },
            height = {
              name = COMPACT_UNIT_FRAME_PROFILE_FRAMEHEIGHT,
              type = "range",
              order = 38,
              min = 36 * 5,
              max = 72 * 5,
              softMin = 36 * 5,
              softMax = 72 * 5,
              step = 1,
              set = function(info, value)
                AddOn.db.profile.height = value
                for groupType, header in pairs(AddOn.headers) do
                  for i = 1, #header do
                    local frame = header[i]
                    AddOn.DefaultSetup(frame, groupType)
                  end
                end
              end,
              get = function(info)
                return AddOn.db.profile.height
              end
            },
            width = {
              name = COMPACT_UNIT_FRAME_PROFILE_FRAMEWIDTH,
              type = "range",
              order = 39,
              min = 72 * 5,
              max = 144 * 5,
              softMin = 72 * 5,
              softMax = 144 * 5,
              step = 1,
              set = function(info, value)
                AddOn.db.profile.width = value
                for groupType, header in pairs(AddOn.headers) do
                  for i = 1, #header do
                    local frame = header[i]
                    AddOn.DefaultSetup(frame, groupType)
                  end
                end
              end,
              get = function(info)
                return AddOn.db.profile.width
              end
            },
            lb27 = {
              name = "", order = 40, type = "description",
            },
            lb28 = {
              name = "", order = 41, type = "description",
            },
            offsetX = {
              name = "Décalage X",
              type = "range",
              order = 42,
              min = 0,
              max = 1920,
              softMin = 0,
              softMax = 1920,
              step = 1,
              set = function(info, value)
                AddOn.db.profile.offsetX = value
                for _, header in pairs(AddOn.headers) do
                  header:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", AddOn.db.profile.offsetX, AddOn.db.profile.offsetY)
                end
              end,
              get = function(info)
                return AddOn.db.profile.offsetX
              end
            },
            offsetY = {
              name = "Décalage Y",
              type = "range",
              order = 43,
              min = 0,
              max = 1080,
              softMin = 0,
              softMax = 1080,
              step = 1,
              set = function(info, value)
                AddOn.db.profile.offsetY = value
                for _, header in pairs(AddOn.headers) do
                  header:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", AddOn.db.profile.offsetX, AddOn.db.profile.offsetY)
                end
              end,
              get = function(info)
                return AddOn.db.profile.offsetY
              end
            },
            lb29 = {
              name = "", order = 44, type = "description",
            },
            lb30 = {
              name = "", order = 45, type = "description",
            },
            displayPartyGroup = {
              name = "Afficher en groupe",
              type = "toggle",
              order= 46,
              set = function(info, value)
                AddOn.db.profile.displayPartyGroup = value
              end,
              get = function(info)
                return AddOn.db.profile.displayPartyGroup
              end
            }
          }
        },
      },
      plugins = {
        profiles = {
          profiles = AddOn.config.profiles
        },
      },
    }
  end

  return AddOn.options
end

function AddOn:OnInitialize()
  self.db = LibStub("AceDB-3.0"):New("RaidFramesDB", self.defaults, true)
  --self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
  --self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
  --self.db.RegisterCallback(self, "OnProfileReset", "Refresh")

  self.global = self.db.global
  self.profile = self.db.profile

  AceConfigRegistry:RegisterOptionsTable(ADDON_NAME, GetOptions)
  self.config = AceConfigDialog:AddToBlizOptions(ADDON_NAME)
  --self.config:GetRegions():ClearAllPoints()
  --self.config:GetRegions():SetPoint("TOPLEFT", 16, -16) -- reposition title

  self.config.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
end

function AddOn:OnEnable()

end

function AddOn:OnDisable()

end

local function debug(...)
  _G[ADDON_NAME] = _G[ADDON_NAME] or AddOn
  if not ... then return end
  if type(...) == "table" then
    print("|cff33ff99" .. ADDON_NAME .. ":|r")
    DevTools_Dump(...)
  else
    print("|cff33ff99" .. ADDON_NAME .. ":|r", ...)
  end
end

-- Widget Handlers
local OPTION_TABLE_NONE = {}

local function RunProtectedFunction(frame, func)
  local f = CreateFrame("Frame")
  if not InCombatLockdown() then
    debug("Not in combat.")
    f:UnregisterEvent("PLAYER_REGEN_ENABLED")
    f:SetScript("OnEvent", nil)
    func(frame)
  else
    debug("In combat.")
    f:RegisterEvent("PLAYER_REGEN_ENABLED")
    f:SetScript("OnEvent", function(_, event)
      f:UnregisterEvent(event)
      f:SetScript("OnEvent", nil)
      func(frame)
      debug("Function run")
    end)
  end
end

function AddOn:ConstructFrames()
  self:SetScript("OnEnter", function()
    UnitFrame_OnEnter(self)
    if InCombatLockdown() then
      GameTooltip:Hide()
    end
    self.mouseIsOver = true
  end)
  self:SetScript("OnLeave", function()
    UnitFrame_OnLeave(self)
    self.mouseIsOver = false
  end)

  local background = self:CreateTexture("$parentBackground", "BACKGROUND")
  background:SetAllPoints()
  background:SetIgnoreParentAlpha(true)

  local myHealPrediction = self:CreateTexture("$parentMyHealPrediction", "BORDER", nil, 5)
  local otherHealPrediction = self:CreateTexture("$parentOtherHealPrediction", "BORDER", nil, 5)
  local totalAbsorb = self:CreateTexture("$parentTotalAbsorb", "BORDER", nil, 5)

  local totalAbsorbOverlay = self:CreateTexture("$parentTotalAbsorbOverlay", "BORDER", nil, 6)

  -- TODO: Need to add ContainerBorderFrame.
  local horizDivider = self:CreateTexture("$parentHorizDivider", "BORDER")
  horizDivider:SetHorizTile(true)
  horizDivider:SetIgnoreParentAlpha(true)
  local horizTopBorder = self:CreateTexture("$parentHorizTopBorder", "BORDER")
  horizTopBorder:SetHorizTile(true)
  horizTopBorder:SetIgnoreParentAlpha(true)
  local horizBottomBorder = self:CreateTexture("$parentHorizBottomBorder", "BORDER")
  horizBottomBorder:SetHorizTile(true)
  horizBottomBorder:SetIgnoreParentAlpha(true)
  local vertLeftBorder = self:CreateTexture("$parentVertLeftBorder", "BORDER")
  vertLeftBorder:SetVertTile(true)
  vertLeftBorder:SetIgnoreParentAlpha(true)
  local vertRightBorder = self:CreateTexture("$parentVertRightBorder", "BORDER")
  vertRightBorder:SetVertTile(true)
  vertRightBorder:SetIgnoreParentAlpha(true)

  local name = self:CreateFontString("$parentName", "ARTWORK", "GameFontHighlightSmall")
  name:SetWordWrap(false)
  local statusText = self:CreateFontString("$parentStatusText", "ARTWORK", "GameFontDisable")
  local roleIcon = self:CreateTexture("$parentRoleIcon", "ARTWORK")
  roleIcon:Hide()
  local aggroHighlight = self:CreateTexture("$parentAggroHighlight", "ARTWORK")

  local myHealAbsorb = self:CreateTexture("$parentMyHealAbsorb", "ARTWORK", nil, 1)
  local myHealAbsorbLeftShadow = self:CreateTexture("$parentMyHealAbsorbLeftShadow", "ARTWORK", nil, 1)
  myHealAbsorbLeftShadow:SetTexture("Interface\\RaidFrame\\Absorb-Edge")
  local myHealAbsorbRightShadow = self:CreateTexture("$parentMyHealAbsorbRightShadow", "ARTWORK", nil, 1)
  myHealAbsorbRightShadow:SetTexture("Interface\\RaidFrame\\Absorb-Edge")
  myHealAbsorbRightShadow:SetTexCoord(1, 0, 0, 1)

  local overAbsorbGlow = self:CreateTexture("$parentOverAbsorbGlow", "ARTWORK", nil, 2)
  local overHealAbsorbGlow = self:CreateTexture("$parentOverHealAbsorbGlow", "ARTWORK", nil, 2)

  local selectionHighlight = self:CreateTexture("$parentSelectionHighlight", "OVERLAY")
  selectionHighlight:SetIgnoreParentAlpha(true)
  local readyCheckIcon = self:CreateTexture("$parentReadyCheckIcon", "OVERLAY")
  readyCheckIcon:SetIgnoreParentAlpha(true)

  local healthBar = CreateFrame("StatusBar", "$parentHealthBar", self)
  healthBar:SetFrameLevel(self:GetFrameLevel())
  Mixin(healthBar, SmoothStatusBarMixin)
  local healthBarBackground = healthBar:CreateTexture("$parentBackground", "BACKGROUND", nil, 2)
  healthBarBackground:SetAllPoints()
  local powerBar = CreateFrame("StatusBar", "$parentPowerBar", self)
  powerBar:SetFrameLevel(self:GetFrameLevel())
  Mixin(powerBar, SmoothStatusBarMixin)
  local powerBarBackground = powerBar:CreateTexture("$parentBackground", "BACKGROUND", nil, 2)
  powerBarBackground:SetAllPoints()

  for i = 1, 3 do
    local buffFrame = CreateFrame("Button", "$parentBuff" .. i, self, "CompactBuffTemplate")
    local debuffFrame = CreateFrame("Button", "$parentDebuff" .. i, self, "CompactDebuffTemplate")
    local dispelDebuffFrame = CreateFrame("Button", "$parentDispelDebuff" .. i, self, "CompactDispelDebuffTemplate")
    self.buffFrames[i] = buffFrame
    self.debuffFrames[i] = debuffFrame
    self.dispelDebuffFrames[i] = dispelDebuffFrame
  end

  local centerStatusIcon = CreateFrame("Button", "$parentCenterStatusIcon", self)
  centerStatusIcon:RegisterForClicks("RightButtonUp") -- TODO: "LeftButtonDown" triggers TargetUnit(), a protected function, so take it appart for now.
  centerStatusIcon:SetScript("OnClick", function(self, button)
    self:GetParent():GetScript("OnClick")(self:GetParent(), button)
  end)
  centerStatusIcon:SetScript("OnEnter", function(self, motion)
    if self.tooltip then
      GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
      GameTooltip:SetText(self.tooltip, nil, nil, nil, nil, true)
      GameTooltip:Show()
    else
      local onEnter =  self:GetParent():GetScript("OnEnter")
      onEnter(self:GetParent(), motion) -- TODO: This throws "Cannot call restricted closure from insecure code".
    end
  end)
  centerStatusIcon:SetScript("OnLeave", function(self, motion)
    if self.tooltip then
      GameTooltip:Hide()
    else
      local onLeave =  self:GetParent():GetScript("OnLeave")
      onLeave(self:GetParent(), motion) -- TODO: This throws "Cannot call restricted closure from insecure code".
    end
  end)
  local centerStatusIconTexture = centerStatusIcon:CreateTexture(nil, "ARTWORK")
  centerStatusIconTexture:SetAllPoints()
  local centerStatusIconBorder = centerStatusIcon:CreateTexture(nil, "BORDER")
  centerStatusIconBorder:SetAllPoints()

  local dropDown = CreateFrame("Frame", "$parentDropDown", self, "UIDropDownMenuTemplate")
  dropDown:SetSize(10, 10)
  dropDown:SetPoint("TOP", 10, -60)
  dropDown:Hide()

  self.background = background
  self.myHealPrediction = myHealPrediction
  self.otherHealPrediction = otherHealPrediction
  self.totalAbsorb = totalAbsorb
  self.totalAbsorbOverlay = totalAbsorbOverlay
  self.horizDivider = horizDivider
  self.horizTopBorder = horizTopBorder
  self.horizBottomBorder = horizBottomBorder
  self.vertLeftBorder = vertLeftBorder
  self.vertRightBorder = vertRightBorder
  self.name = name
  self.statusText = statusText
  self.roleIcon = roleIcon
  self.aggroHighlight = aggroHighlight
  self.myHealAbsorb = myHealAbsorb
  self.myHealAbsorbLeftShadow = myHealAbsorbLeftShadow
  self.myHealAbsorbRightShadow = myHealAbsorbRightShadow
  self.overAbsorbGlow = overAbsorbGlow
  self.overHealAbsorbGlow = overHealAbsorbGlow
  self.selectionHighlight = selectionHighlight
  self.readyCheckIcon = readyCheckIcon
  self.healthBar = healthBar
  self.healthBar.background = healthBarBackground
  self.powerBar = powerBar
  self.powerBar.background = powerBarBackground
  self.centerStatusIcon = centerStatusIcon
  self.centerStatusIcon.texture = centerStatusIconTexture
  self.centerStatusIcon.border = centerStatusIconBorder
  self.dropDown = dropDown

  self:RegisterEvent("PLAYER_ENTERING_WORLD")
  self:RegisterEvent("UNIT_DISPLAYPOWER")
  self:RegisterEvent("UNIT_POWER_BAR_SHOW")
  self:RegisterEvent("UNIT_POWER_BAR_HIDE")
  self:RegisterEvent("UNIT_NAME_UPDATE")
  self:RegisterEvent("PLAYER_TARGET_CHANGED")
  self:RegisterEvent("PLAYER_REGEN_ENABLED")
  self:RegisterEvent("PLAYER_REGEN_DISABLED")
  self:RegisterEvent("UNIT_CONNECTION")
  self:RegisterEvent("PLAYER_ROLES_ASSIGNED")
  self:RegisterEvent("UNIT_ENTERED_VEHICLE")
  self:RegisterEvent("UNIT_EXITED_VEHICLE")
  self:RegisterEvent("UNIT_PET")
  self:RegisterEvent("READY_CHECK")
  self:RegisterEvent("READY_CHECK_FINISHED")
  self:RegisterEvent("READY_CHECK_CONFIRM")
  self:RegisterEvent("PARTY_MEMBER_DISABLE")
  self:RegisterEvent("PARTY_MEMBER_ENABLE")
  self:RegisterEvent("INCOMING_RESURRECT_CHANGED")
  self:RegisterEvent("UNIT_OTHER_PARTY_CHANGED")
  self:RegisterEvent("UNIT_ABSORB_AMOUNT_CHANGED")
  self:RegisterEvent("UNIT_HEAL_ABSORB_AMOUNT_CHANGED")
  self:RegisterEvent("UNIT_PHASE")
  self:RegisterEvent("UNIT_CTR_OPTIONS")
  self:RegisterEvent("UNIT_FLAGS")
  self:RegisterEvent("INCOMING_SUMMON_CHANGED")
  self:RegisterEvent("GROUP_ROSTER_UPDATE")
  -- also see UpdateUnitEvents for more events

  self.maxBuffs = 0
  self.maxDebuffs = 0
  self.maxDispelDebuffs = 0
  AddOn:SetOptionTable(self, OPTION_TABLE_NONE)
  AddOn:SetUpClicks(self)
  AddOn:SetUpFrame(self, AddOn.DefaultSetup)
end

function AddOn:OnEvent(event, arg1)
  if event == "GROUP_ROSTER_UPDATE" then
    AddOn:UpdateAll(self, true)
  elseif event == "PLAYER_ENTERING_WORLD" then
    local inInstance, instanceType = IsInInstance()
    --SetCVar("chatBubbles", isInstance and "0" or "1")
    --SetCVar("chatBubblesParty", "1")
    SetCVar("cameraSmoothTrackingStyle", inInstance and "0" or "4")
    SetCVar("nameplateShowFriendlyNPCs", inInstance and instanceType == "raid" and "1" or "0")
    AddOn:UpdateAll(self)
  elseif event == "PLAYER_TARGET_CHANGED" then
    AddOn:UpdateSelectionHighlight(self)
    AddOn:UpdateName(self)
  elseif event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED" then
    if self.mouseIsOver then
      GameTooltip:Hide()
    end
    AddOn:UpdateAuras(self) -- We filter differently based on whether the player is in Combat, so we need to update when that changes.
  elseif event == "PLAYER_ROLES_ASSIGNED" then
    AddOn:UpdateRoleIcon(self)
  elseif event == "READY_CHECK" then
    AddOn:UpdateReadyCheck(self)
  elseif event == "READY_CHECK_FINISHED" then
    AddOn:FinishReadyCheck(self)
  elseif event == "PARTY_MEMBER_DISABLE" or event == "PARTY_MEMBER_ENABLE" then -- Alternate power info may now be available.
    AddOn:UpdateMaxPower(self)
    AddOn:UpdatePower(self)
    AddOn:UpdatePowerColor(self)
  else
    local unitMatches = arg1 == self.unit or arg1 == self.displayedUnit
    if unitMatches then
      if event == "UNIT_MAXHEALTH" then
        AddOn:UpdateMaxHealth(self)
        AddOn:UpdateHealth(self)
        AddOn:UpdateHealPrediction(self)
      elseif event == "UNIT_HEALTH" then
        AddOn:UpdateHealth(self)
        AddOn:UpdateStatusText(self)
        AddOn:UpdateHealPrediction(self)
      elseif event == "UNIT_MAXPOWER" then
        AddOn:UpdateMaxPower(self)
        AddOn:UpdatePower(self)
      elseif event == "UNIT_POWER_UPDATE" then
        AddOn:UpdatePower(self)
      elseif event == "UNIT_DISPLAYPOWER" or event == "UNIT_POWER_BAR_SHOW" or event == "UNIT_POWER_BAR_HIDE" then
        AddOn:UpdateMaxPower(self)
        AddOn:UpdatePower(self)
        AddOn:UpdatePowerColor(self)
      elseif event == "UNIT_NAME_UPDATE" then
        AddOn:UpdateName(self)
        AddOn:UpdateHealth(self)      -- This may signify that the unit is a new pet who replaced an old pet, and needs a health update.
        AddOn:UpdateHealthColor(self) -- This may signify that we now have the unit's class (the name cache entry has been received).
      elseif event == "UNIT_AURA" then
        AddOn:UpdateAuras(self)
      elseif event == "UNIT_THREAT_SITUATION_UPDATE" then
        AddOn:UpdateAggroHighlight(self)
      elseif event == "UNIT_CONNECTION" then
        -- Might want to set the health/mana to max as well so it's easily visible? This happens unless the player is out of AOI.
        AddOn:UpdateHealthColor(self)
        AddOn:UpdatePowerColor(self)
        AddOn:UpdateStatusText(self)
      elseif event == "UNIT_HEAL_PREDICTION" then
        AddOn:UpdateHealPrediction(self)
      elseif event == "UNIT_PET" then
        AddOn:UpdateAll(self)
      elseif event == "READY_CHECK_CONFIRM" then
        AddOn:UpdateReadyCheck(self)
      elseif event == "INCOMING_RESURRECT_CHANGED" then
        AddOn:UpdateCenterStatusIcon(self)
      elseif event == "UNIT_OTHER_PARTY_CHANGED" then
        AddOn:UpdateCenterStatusIcon(self)
      elseif event == "UNIT_ABSORB_AMOUNT_CHANGED" then
        AddOn:UpdateHealPrediction(self)
      elseif event == "UNIT_HEAL_ABSORB_AMOUNT_CHANGED" then
        AddOn:UpdateHealPrediction(self)
      elseif event == "PLAYER_FLAGS_CHANGED" then
        AddOn:UpdateStatusText(self)
      elseif event == "UNIT_PHASE" or event == "UNIT_FLAGS" or event == "UNIT_CTR_OPTIONS" then
        AddOn:UpdateCenterStatusIcon(self)
      elseif event == "INCOMING_SUMMON_CHANGED" then
        AddOn:UpdateCenterStatusIcon(self)
      end
    end

    if unitMatches or arg1 == "player" then
      if event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE" then
        AddOn:UpdateAll(self)
      end
    end
  end
end

-- DEBUG FIXME - We should really try to avoid having OnUpdate on every frame. An event when going in/out of range would be greatly preferred.
function AddOn:OnUpdate(elapsed)
  AddOn:UpdateInRange(self)
  AddOn:UpdateDistance(self)
  AddOn:CheckReadyCheckDecay(self, elapsed)
end

-- Externally accessed functions
function AddOn:SetUnit(frame, unit)
  if unit ~= frame.unit then
    frame.unit = unit
    frame.displayedUnit = unit -- May differ from unit if unit is in a vehicle.
    frame.readyCheckStatus = nil
    frame.readyCheckDecay = nil
    if unit then
      self:RegisterEvents(frame)
    else
      self:UnregisterEvents(frame)
    end
    self:UpdateAll(frame)
  end
end

-- Things you'll have to set up to get everything looking right:
-- 1. Frame size
-- 2. Health/Mana bar positions
-- 3. Health/Mana bar textures (also, optionally, background textures)
-- 4. Name position
-- 5. Buff/Debuff/Dispellable positions
-- 6. Call SetMaxBuffs, _SetMaxDebuffs, and _SetMaxDispelDebuffs. (If you're setting it to greater than the default, make sure to create new buff/debuff frames and position them.)
-- 7. Selection highlight position and texture.
-- 8. Aggro highlight position and texture
-- 9. Role icon position
function AddOn:SetUpFrame(frame, func)
  func(frame)
  self:UpdateAll(frame)
end

function AddOn:SetOptionTable(frame, optionTable)
  frame.optionTable = optionTable
end

function AddOn:RegisterEvents(frame)
  frame:SetScript("OnEvent", self.OnEvent)
  self:UpdateUnitEvents(frame)
  frame:SetScript("OnUpdate", self.OnUpdate)
end

function AddOn:UpdateUnitEvents(frame)
  local unit = frame.unit
  local displayedUnit
  if unit ~= frame.displayedUnit then
    displayedUnit = frame.displayedUnit
  end
  frame:RegisterUnitEvent("UNIT_MAXHEALTH", unit, displayedUnit)
  frame:RegisterUnitEvent("UNIT_HEALTH", unit, displayedUnit)
  frame:RegisterUnitEvent("UNIT_MAXPOWER", unit, displayedUnit)
  frame:RegisterUnitEvent("UNIT_POWER_UPDATE", unit, displayedUnit)
  frame:RegisterUnitEvent("UNIT_AURA", unit, displayedUnit)
  frame:RegisterUnitEvent("UNIT_THREAT_SITUATION_UPDATE", unit, displayedUnit)
  frame:RegisterUnitEvent("UNIT_HEAL_PREDICTION", unit, displayedUnit)
  frame:RegisterUnitEvent("PLAYER_FLAGS_CHANGED", unit, displayedUnit)
end

function AddOn:UnregisterEvents(frame)
  frame:SetScript("OnEvent", nil)
  frame:SetScript("OnUpdate", nil)
end

function AddOn:SetUpClicks(frame)
  -- NOTE: Make sure you also change the CompactAuraTemplate. (It has to be registered for clicks to be able to pass them through.)
  frame:RegisterForClicks("LeftButtonDown", "RightButtonUp")
  self:SetMenuFunc(frame, self.DropDown_Initialize)
end

function AddOn:SetMenuFunc(frame, menuFunc)
  UIDropDownMenu_Initialize(frame.dropDown, menuFunc, "MENU")
  frame.menu = function()
    ToggleDropDownMenu(1, nil, frame.dropDown, frame:GetName(), 0, 0)
  end
end

function AddOn:SetMaxBuffs(frame, numBuffs)
  frame.maxBuffs = numBuffs
end

function AddOn:SetMaxDebuffs(frame, numDebuffs)
  frame.maxDebuffs = numDebuffs
end

function AddOn:SetMaxDispelDebuffs(frame, numDispelDebuffs)
  frame.maxDispelDebuffs = numDispelDebuffs
end

-- Update Functions
function AddOn:UpdateAll(frame, rosterUpdate)
  if rosterUpdate then

  end
  self:UpdateInVehicle(frame)
  self:UpdateVisible(frame)
  if UnitExists(frame.displayedUnit) then
    self:UpdateMaxHealth(frame)
    self:UpdateHealth(frame)
    self:UpdateHealthColor(frame)
    self:UpdatePowerBarVisibility(frame)
    self:UpdateMaxPower(frame)
    self:UpdatePower(frame)
    self:UpdatePowerColor(frame)
    self:UpdateName(frame)
    self:UpdateSelectionHighlight(frame)
    self:UpdateAggroHighlight(frame)
    self:UpdateInRange(frame)
    self:UpdateStatusText(frame)
    self:UpdateHealPrediction(frame)
    self:UpdateRoleIcon(frame)
    self:UpdateReadyCheck(frame)
    self:UpdateAuras(frame)
    self:UpdateCenterStatusIcon(frame)
  end

  -- DerangementShieldMeters
  if not frame.totalAbsorb or frame.totalAbsorb:IsForbidden() then return end

  if not frame.totalAbsorbOverlay or frame.totalAbsorbOverlay:IsForbidden() then return end

  if not frame.healthBar or frame.healthBar:IsForbidden() then return end

  frame.totalAbsorbOverlay:SetParent(frame.healthBar)
  frame.totalAbsorbOverlay:ClearAllPoints()		--we'll be attaching the overlay on heal prediction update.

  if frame.overAbsorbGlow and not frame.overAbsorbGlow:IsForbidden() then
    frame.overAbsorbGlow:ClearAllPoints()
    frame.overAbsorbGlow:SetPoint("TOPLEFT", frame.totalAbsorbOverlay, "TOPLEFT", -5, 0)
    frame.overAbsorbGlow:SetPoint("BOTTOMLEFT", frame.totalAbsorbOverlay, "BOTTOMLEFT", -5, 0)
    frame.overAbsorbGlow:SetAlpha(0.6)
  end
end

function AddOn:UpdatePowerBarVisibility(frame)
  local options = self.DefaultSetupOptions
  local role = UnitGroupRolesAssigned(frame.unit)
  local _, class = UnitClass(frame.unit)
  local displayPowerBar = options.displayPowerBar and role == "HEALER" or options.displayPowerBar and class == "DEATHKNIGHT" and role == "TANK"
  local powerBarHeight = 8
  local powerBarUsedHeight = displayPowerBar and powerBarHeight or 0

  frame.healthBar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -1, 1 + powerBarUsedHeight)

  if displayPowerBar then
    if options.displayBorder then
      frame.powerBar:SetPoint("TOPLEFT", frame.healthBar, "BOTTOMLEFT", 0, -2)
    else
      frame.powerBar:SetPoint("TOPLEFT", frame.healthBar, "BOTTOMLEFT", 0, 0)
    end
    frame.powerBar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -1, 1)
    frame.powerBar:SetStatusBarTexture("Interface\\RaidFrame\\Raid-Bar-Resource-Fill", "BORDER")
    frame.powerBar.background:SetTexture("Interface\\RaidFrame\\Raid-Bar-Resource-Background")
    frame.powerBar:Show()
  else
    frame.powerBar:Hide()
  end

  frame.buffFrames[1]:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, CUF_AURA_BOTTOM_OFFSET + powerBarUsedHeight)

  frame.debuffFrames[1]:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 3, CUF_AURA_BOTTOM_OFFSET + powerBarUsedHeight)
  for i = 1, #frame.debuffFrames do
    frame.debuffFrames[i].maxHeight = options.height - powerBarUsedHeight - CUF_AURA_BOTTOM_OFFSET - CUF_NAME_SECTION_SIZE
  end

  if options.displayBorder then
    if displayPowerBar then
      frame.horizDivider:ClearAllPoints()
      frame.horizDivider:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 1 + powerBarUsedHeight)
      frame.horizDivider:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", 0, 1 + powerBarUsedHeight)
      frame.horizDivider:SetTexture("Interface\\RaidFrame\\Raid-HSeparator")
      frame.horizDivider:SetHeight(8)
      frame.horizDivider:Show()
    else
      frame.horizDivider:Hide()
    end
  end
end

function AddOn:UpdateInVehicle(frame)
  local shouldTargetVehicle = UnitHasVehicleUI(frame.unit)
  local unitVehicleToken

  if shouldTargetVehicle then
    local raidID = UnitInRaid(frame.unit)
    if raidID and not UnitTargetsVehicleInRaidUI(frame.unit) then
      shouldTargetVehicle = false
    end
  end

  if shouldTargetVehicle then
    local prefix, id, suffix = string.match(frame.unit, "([^%d]+)([%d]*)(.*)")
    unitVehicleToken = prefix .. "pet" .. id .. suffix
    if not UnitExists(unitVehicleToken) then
      shouldTargetVehicle = false
    end
  end

  if shouldTargetVehicle then
    if not frame.hasValidVehicleDisplay then
      frame.hasValidVehicleDisplay = true
      frame.displayedUnit = unitVehicleToken
      self:UpdateUnitEvents(frame)
    end
  else
    if frame.hasValidVehicleDisplay then
      frame.hasValidVehicleDisplay = false
      frame.displayedUnit = frame.unit
      self:UpdateUnitEvents(frame)
    end
  end
end

function AddOn:UpdateVisible(frame)
  if UnitExists(frame.unit) or UnitExists(frame.displayedUnit) then
    if not frame.unitExists then
      frame.newUnit = true
    end

    frame.unitExists = true
  else
    frame.unitExists = false
  end
end

function AddOn:UpdateHealthColor(frame)
  local r, g, b
  if not UnitIsConnected(frame.unit) then
    -- Color it gray
    r, g, b = 0.5, 0.5, 0.5
  else
    if frame.optionTable.healthBarColorOverride then
      local healthBarColorOverride = frame.optionTable.healthBarColorOverride
      r, g, b = healthBarColorOverride.r, healthBarColorOverride.g, healthBarColorOverride.b
    else
      -- Try to color it by class.
      local _, englishClass = UnitClass(frame.unit)
      local classColor = RAID_CLASS_COLORS[englishClass]
      --debug
      --classColor = RAID_CLASS_COLORS["PRIEST"];
      if (frame.optionTable.allowClassColorsForNPCs or UnitIsPlayer(frame.unit) or UnitTreatAsPlayerForDisplay(frame.unit)) and classColor and frame.optionTable.useClassColors then
        -- Use class colors for players if class color option is turned on
        r, g, b = classColor.r, classColor.g, classColor.b
      elseif UnitIsFriend("player", frame.unit) then
        r, g, b = 0, 1, 0
      else
        r, g, b = 1, 0, 0
      end
    end
  end
  if r ~= frame.healthBar.r or g ~= frame.healthBar.g or b ~= frame.healthBar.b then
    frame.healthBar:SetStatusBarColor(r, g, b)

    if frame.optionTable.colorHealthWithExtendedColors then
      frame.selectionHighlight:SetVertexColor(r, g, b)
    else
      frame.selectionHighlight:SetVertexColor(1, 1, 1)
    end

    frame.healthBar.r, frame.healthBar.g, frame.healthBar.b = r, g, b
  end
end

function AddOn:UpdateMaxHealth(frame)
  local maxHealth = UnitHealthMax(frame.displayedUnit)
  if frame.optionTable.smoothUpdates then
    frame.healthBar:SetMinMaxSmoothedValue(0, maxHealth)
  else
    frame.healthBar:SetMinMaxValues(0, maxHealth)
  end

  self:UpdateHealPrediction(frame)
end

function AddOn:UpdateHealth(frame)
  local health = UnitHealth(frame.displayedUnit)
  if frame.optionTable.smoothUpdates then
    if frame.newUnit then
      frame.healthBar:ResetSmoothedValue(health)
      frame.newUnit = false
    else
      frame.healthBar:SetSmoothedValue(health)
    end
  else
    PixelUtil.SetStatusBarValue(frame.healthBar, health)
  end
end

local function GetDisplayedPowerID(frame)
  local barInfo = GetUnitPowerBarInfo(frame.displayedUnit)
  if barInfo and barInfo.showOnRaid and (UnitInParty(frame.unit) or UnitInRaid(frame.unit)) then
    return ALTERNATE_POWER_INDEX
  else
    return (UnitPowerType(frame.displayedUnit))
  end
end

function AddOn:UpdateMaxPower(frame)
  local maxPower = UnitPowerMax(frame.displayedUnit, GetDisplayedPowerID(frame))
  if frame.optionTable.smoothUpdates then
    frame.powerBar:SetMinMaxSmoothedValue(0, maxPower)
  else
    frame.powerBar:SetMinMaxValues(0, maxPower)
  end
end

function AddOn:UpdatePower(frame)
  local power = UnitPower(frame.displayedUnit, GetDisplayedPowerID(frame))
  if frame.optionTable.smoothUpdates then
    if frame.newUnit then
      frame.powerBar:ResetSmoothedValue(power)
      frame.newUnit = false
    else
      frame.powerBar:SetSmoothedValue(power)
    end
  else
    PixelUtil.SetStatusBarValue(frame.powerBar, power)
  end
end

function AddOn:UpdatePowerColor(frame)
  local r, g, b
  if not UnitIsConnected(frame.unit) then
    -- Color it gray
    r, g, b = 0.5, 0.5, 0.5
  else
    -- TODO: Mana of the Restoration Druid sometimes appears as Maelstrom.
    -- Set it to the proper power type color.
    local barInfo = GetUnitPowerBarInfo(frame.unit)
    if barInfo and barInfo.showOnRaid then
      r, g, b = 0.7, 0.7, 0.6
    else
      --local role = UnitGroupRolesAssigned(frame.unit)
      --local _, class = UnitClass(frame.unit)
      local powerType, powerToken, altR, altG, altB = UnitPowerType(frame.displayedUnit)
      local info = PowerBarColor[powerToken]
      if info then
        --if class and class == "DRUID" and role and role == "HEALER" then
        --  debug((frame.name:GetText() or "nil") .. ", info, powerType = " .. (powerType or "nil") .. ", powerToken = " .. (powerToken or "nil") .. ", ", info.r, info.g, info.b)
        --end
        r, g, b = info.r, info.g, info.b
      else
        if not altR then
          -- couldn't find a power token entry...default to indexing by power type or just mana if we don't have that either
          info = PowerBarColor[powerType] or PowerBarColor["MANA"]
          --if class and class == "DRUID" and role and role == "HEALER" then
          --  debug(frame.name:GetText() .. ", not altR, powerType = " .. powerType .. ", powerToken = " .. powerToken .. ", ", info.r, info.g, info.b)
          --end
          r, g, b = info.r, info.g, info.b
        else
          --if class and class == "DRUID" and role and role == "HEALER" then
          --  debug(frame.name:GetText() .. ", altR, powerType = " .. powerType .. ", powerToken = " .. powerToken .. ", ", altR, altG, altB)
          --end
          r, g, b = altR, altG, altB
        end
      end
    end
  end
  frame.powerBar:SetStatusBarColor(r, g, b)
end

function AddOn:ShouldShowName(frame)
  if frame.optionTable.displayName then
    local failedRequirement = false
    if frame.optionTable.displayNameByPlayerNameRules then
      if UnitShouldDisplayName(frame.unit) then
        return true
      end
      failedRequirement = true
    end

    if frame.optionTable.displayNameWhenSelected then
      if UnitIsUnit(frame.unit, "target") then
        return true
      end
      failedRequirement = true
    end

    return not failedRequirement
  end

  return false
end

function AddOn:UpdateName(frame)
  if not self:ShouldShowName(frame) then
    frame.name:Hide()
  else
    local unitName = GetUnitName(frame.unit, true)
    if UnitInRaid(frame.unit) then
      for i = 1, GetNumGroupMembers() do
        local name, _, subGroup = GetRaidRosterInfo(i)
        if name == unitName then
          frame.name:SetText("(" .. subGroup .. ")" .. unitName)
          break
        end
      end
    else
      frame.name:SetText(unitName)
    end
    frame.name:Show()
  end
end

function AddOn:UpdateSelectionHighlight(frame)
  if not frame.optionTable.displaySelectionHighlight then
    frame.selectionHighlight:Hide()
    return
  end

  if UnitIsUnit(frame.displayedUnit, "target") then
    frame.selectionHighlight:Show()
  else
    frame.selectionHighlight:Hide()
  end
end

function AddOn:UpdateAggroHighlight(frame)
  if not frame.optionTable.displayAggroHighlight then
    return
  end

  local status = UnitThreatSituation(frame.displayedUnit)
  if status and status > 0 then
    frame.aggroHighlight:SetVertexColor(GetThreatStatusColor(status))
    frame.aggroHighlight:Show()
  else
    frame.aggroHighlight:Hide()
  end
end

function AddOn:UpdateInRange(frame)
  if not frame.optionTable.fadeOutOfRange then
    return
  end

  local inRange, checkedRange = UnitInRange(frame.displayedUnit)
  if checkedRange and not inRange then -- If we weren't able to check the range for some reason, we'll just treat them as in-range (for example, enemy units)
    frame:SetAlpha(0.55)
  else
    frame:SetAlpha(1)
  end
end

function AddOn:UpdateDistance(frame)
  local distance, checkedDistance = UnitDistanceSquared(frame.displayedUnit)

  if checkedDistance then
    local inDistance = distance < DISTANCE_THRESHOLD_SQUARED
    if inDistance ~= frame.inDistance then
      frame.inDistance = inDistance
      self:UpdateCenterStatusIcon(frame)
    end
  end
end

function AddOn:UpdateStatusText(frame)
  if not frame.optionTable.displayStatusText then
    frame.statusText:Hide()
    return
  end

  if not UnitIsConnected(frame.unit) then
    frame.statusText:SetText(PLAYER_OFFLINE)
    frame.statusText:Show()
  elseif UnitIsDeadOrGhost(frame.displayedUnit) then
    -- TODO: This doesn't seem to always work since the release of Shadowlands. No text is displayed when a player is nearly one-shotted.
    frame.statusText:SetText(DEAD)
    frame.statusText:Show()
  elseif frame.optionTable.healthText == "health" then
    frame.statusText:SetText(UnitHealth(frame.displayedUnit))
    frame.statusText:Show()
  elseif frame.optionTable.healthText == "losthealth" then
    local healthLost = UnitHealthMax(frame.displayedUnit) - UnitHealth(frame.displayedUnit)
    if healthLost > 0 then
      frame.statusText:SetFormattedText(LOST_HEALTH, healthLost)
      frame.statusText:Show()
    else
      frame.statusText:Hide()
    end
  elseif frame.optionTable.healthText == "perc" and UnitHealthMax(frame.displayedUnit) > 0 then
    local perc = math.ceil(100 * (UnitHealth(frame.displayedUnit) / UnitHealthMax(frame.displayedUnit)))
    frame.statusText:SetFormattedText("%d%%", perc)
    frame.statusText:Show()
  else
    frame.statusText:Hide()
  end
end

local fakeIndex = 1
local fakeSetup = {
  {
    myHeal = 1000,
    allHeal = 1500,
    absorb = 1200,
    healAbsorb = 0,
    healthMult = .5
  },
  {
    myHeal = 2500,
    allHeal = 5000,
    absorb = 2000,
    healAbsorb = 12000,
    healthMult = .5
  }
}

-- WARNING: This function is very similar to the function UnitFrameHealPredictionBars_Update in UnitFrame.lua.
-- If you are making changes here, it is possible you may want to make changes there as well.
local MAX_INCOMING_HEAL_OVERFLOW = 1.05
function AddOn:UpdateHealPrediction(frame)
  --if not frame.fakeIndex then
  --	frame.fakeIndex = fakeIndex
  --	fakeIndex = fakeIndex + 1
  --	if fakeIndex > #fakeSetup then
  --		fakeIndex = 1
  --	end
  --end
  --local fake = fakeSetup[frame.fakeIndex]

  local _, maxHealth = frame.healthBar:GetMinMaxValues()
  local health = frame.healthBar:GetValue()
  --health = maxHealth * fake.healthMult
  --PixelUtil.SetStatusBarValue(frame.healthBar, health)

  if maxHealth <= 0 then
    return
  end

  if not frame.optionTable.displayHealPrediction then
    frame.myHealPrediction:Hide()
    frame.otherHealPrediction:Hide()
    frame.totalAbsorb:Hide()
    frame.totalAbsorbOverlay:Hide()
    frame.overAbsorbGlow:Hide()
    frame.myHealAbsorb:Hide()
    frame.myHealAbsorbLeftShadow:Hide()
    frame.myHealAbsorbRightShadow:Hide()
    frame.overHealAbsorbGlow:Hide()
    return
  end

  local myIncomingHeal = UnitGetIncomingHeals(frame.displayedUnit, "player") or 0
  --myIncomingHeal = fake.myHeal
  local allIncomingHeal = UnitGetIncomingHeals(frame.displayedUnit) or 0
  --allIncomingHeal = fake.allHeal
  local totalAbsorb = UnitGetTotalAbsorbs(frame.displayedUnit) or 0
  --totalAbsorb = fake.absorb

  -- We don't fill outside the health bar with healAbsorbs. Instead, an overHealAbsorbGlow is shown.
  local myCurrentHealAbsorb = UnitGetTotalHealAbsorbs(frame.displayedUnit) or 0
  --myCurrentHealAbsorb = fake.healAbsorb
  if health < myCurrentHealAbsorb then
    frame.overHealAbsorbGlow:Show()
    myCurrentHealAbsorb = health
  else
    frame.overHealAbsorbGlow:Hide()
  end

  -- See how far we're going over the health bar and make sure we don't go too far out of the frame.
  if health - myCurrentHealAbsorb + allIncomingHeal > maxHealth * MAX_INCOMING_HEAL_OVERFLOW then
    allIncomingHeal = maxHealth * MAX_INCOMING_HEAL_OVERFLOW - health + myCurrentHealAbsorb
  end

  --if health + allIncomingHeal > maxHealth then
  --  frame.myHealPrediction:SetGradient("VERTICAL", 93/255, 8/255, 8/255, 136/255, 11/255, 11/255)
  --else
  --  frame.myHealPrediction:SetGradient("VERTICAL", 8/255, 93/255, 72/255, 11/255, 136/255, 105/255)
  --end

  local otherIncomingHeal = 0

  -- Split up incoming heals.
  if allIncomingHeal >= myIncomingHeal then
    otherIncomingHeal = allIncomingHeal - myIncomingHeal
  else
    myIncomingHeal = allIncomingHeal
  end

  local overAbsorb = false
  -- We don't fill outside the the health bar with absorbs. Instead, an overAbsorbGlow is shown.
  if health - myCurrentHealAbsorb + allIncomingHeal + totalAbsorb >= maxHealth or health + totalAbsorb >= maxHealth then
    if totalAbsorb > 0 then
      overAbsorb = true
    end

    if allIncomingHeal > myCurrentHealAbsorb then
      totalAbsorb = max(0,maxHealth - (health - myCurrentHealAbsorb + allIncomingHeal))
    else
      totalAbsorb = max(0,maxHealth - health)
    end
  end
  if overAbsorb then
    frame.overAbsorbGlow:Show()
  else
    frame.overAbsorbGlow:Hide()
  end

  local healthTexture = frame.healthBar:GetStatusBarTexture()

  local myCurrentHealAbsorbPercent = myCurrentHealAbsorb / maxHealth

  local healAbsorbTexture

  -- If allIncomingHeal is greater than myCurrentHealAbsorb, then the current
  -- heal absorb will be completely overlayed by the incoming heals so we don't show it.
  if myCurrentHealAbsorb > allIncomingHeal then
    local shownHealAbsorb = myCurrentHealAbsorb - allIncomingHeal
    local shownHealAbsorbPercent = shownHealAbsorb / maxHealth
    healAbsorbTexture = self:Util_UpdateFillBar(frame, healthTexture, frame.myHealAbsorb, shownHealAbsorb, -shownHealAbsorbPercent)

    -- If there are incoming heals the left shadow would be overlayed by the incoming heals
    -- so it isn't shown.
    if allIncomingHeal > 0 then
      frame.myHealAbsorbLeftShadow:Hide()
    else
      frame.myHealAbsorbLeftShadow:SetPoint("TOPLEFT", healAbsorbTexture, "TOPLEFT", 0, 0)
      frame.myHealAbsorbLeftShadow:SetPoint("BOTTOMLEFT", healAbsorbTexture, "BOTTOMLEFT", 0, 0)
      frame.myHealAbsorbLeftShadow:Show()
    end

    -- The right shadow is only shown if there are absorbs on the health bar.
    if totalAbsorb > 0 then
      frame.myHealAbsorbRightShadow:SetPoint("TOPLEFT", healAbsorbTexture, "TOPRIGHT", -8, 0)
      frame.myHealAbsorbRightShadow:SetPoint("BOTTOMLEFT", healAbsorbTexture, "BOTTOMRIGHT", -8, 0)
      frame.myHealAbsorbRightShadow:Show()
    else
      frame.myHealAbsorbRightShadow:Hide()
    end
  else
    frame.myHealAbsorb:Hide()
    frame.myHealAbsorbRightShadow:Hide()
    frame.myHealAbsorbLeftShadow:Hide()
  end

  -- Show myIncomingHeal on the health bar.
  local incomingHealsTexture = self:Util_UpdateFillBar(frame, healthTexture, frame.myHealPrediction, myIncomingHeal, -myCurrentHealAbsorbPercent)
  -- Append otherIncomingHeal on the health bar.
  incomingHealsTexture = self:Util_UpdateFillBar(frame, incomingHealsTexture, frame.otherHealPrediction, otherIncomingHeal)

  -- Appen absorbs to the correct section of the health bar.
  local appendTexture
  if healAbsorbTexture then
    -- If there is a healAbsorb part shown, append the absorb to the end of that.
    appendTexture = healAbsorbTexture
  else
    -- Otherwise, append the absorb to the end of the the incomingHeals part
    appendTexture = incomingHealsTexture
  end
  self:Util_UpdateFillBar(frame, appendTexture, frame.totalAbsorb, totalAbsorb)

  -- DerangementShieldMeters
  if not frame.totalAbsorb or frame.totalAbsorb:IsForbidden() then return end
  if not frame.totalAbsorbOverlay or frame.totalAbsorbOverlay:IsForbidden() then return end
  if not frame.healthBar or frame.healthBar:IsForbidden() then return end

  _, maxHealth = frame.healthBar:GetMinMaxValues()
  if maxHealth <= 0 then return end

  totalAbsorb = UnitGetTotalAbsorbs(frame.displayedUnit) or 0
  if totalAbsorb > maxHealth then
    totalAbsorb = maxHealth
  end

  if totalAbsorb > 0 then	--show overlay when there's a positive absorb amount
    if frame.totalAbsorb:IsShown() then		--If absorb bar is shown, attach absorb overlay to it; otherwise, attach to health bar.
      frame.totalAbsorbOverlay:SetPoint("TOPRIGHT", frame.totalAbsorb, "TOPRIGHT", 0, 0)
      frame.totalAbsorbOverlay:SetPoint("BOTTOMRIGHT", frame.totalAbsorb, "BOTTOMRIGHT", 0, 0)
    else
      frame.totalAbsorbOverlay:SetPoint("TOPRIGHT", frame.healthBar, "TOPRIGHT", 0, 0)
      frame.totalAbsorbOverlay:SetPoint("BOTTOMRIGHT", frame.healthBar, "BOTTOMRIGHT", 0, 0)
    end

    local totalWidth, totalHeight = frame.healthBar:GetSize()
    local barSize = totalAbsorb / maxHealth * totalWidth

    frame.totalAbsorbOverlay:SetWidth( barSize )
    frame.totalAbsorbOverlay:SetTexCoord(0, barSize / frame.totalAbsorbOverlay.tileSize, 0, totalHeight / frame.totalAbsorbOverlay.tileSize)
    frame.totalAbsorbOverlay:Show()

    --frame.overAbsorbGlow:Show();	--uncomment this if you want to ALWAYS show the glow to the left of the shield overlay
  end
end

-- WARNING: This function is very similar to the function UnitFrameUtil_UpdateFillBar in UnitFrame.lua.
-- If you are making changes here, it is possible you may want to make changes there as well.
function AddOn:Util_UpdateFillBar(frame, previousTexture, bar, amount, barOffsetXPercent)
  local totalWidth, totalHeight = frame.healthBar:GetSize()

  if totalWidth == 0 or amount == 0 then
    bar:Hide()
    if bar.overlay then
      bar.overlay:Hide()
    end
    return previousTexture
  end

  local barOffsetX = 0
  if barOffsetXPercent then
    barOffsetX = totalWidth * barOffsetXPercent
  end

  bar:SetPoint("TOPLEFT", previousTexture, "TOPRIGHT", barOffsetX, 0)
  bar:SetPoint("BOTTOMLEFT", previousTexture, "BOTTOMRIGHT", barOffsetX, 0)

  local _, totalMax = frame.healthBar:GetMinMaxValues()

  local barSize = (amount / totalMax) * totalWidth
  bar:SetWidth(barSize)
  bar:Show()
  if bar.overlay then
    bar.overlay:SetTexCoord(0, barSize / bar.overlay.tileSize, 0, totalHeight / bar.overlay.tileSize)
    bar.overlay:Show()
  end
  return bar
end

function AddOn:UpdateRoleIcon(frame)
  local size = frame.roleIcon:GetHeight() -- We keep the height so that it carries from the set up, but we decrease the width to 1 to allow room for things anchored to the role (e.g. name).
  local raidID = UnitInRaid(frame.unit)
  if UnitInVehicle(frame.unit) and UnitHasVehicleUI(frame.unit) then
    frame.roleIcon:SetTexture("Interface\\Vehicles\\UI-Vehicles-Raid-Icon")
    frame.roleIcon:SetTexCoord(0, 1, 0, 1)
    frame.roleIcon:Show()
    frame.roleIcon:SetSize(size, size)
  elseif frame.optionTable.displayRaidRoleIcon and raidID and select(10, GetRaidRosterInfo(raidID)) then
    local role = select(10, GetRaidRosterInfo(raidID))
    frame.roleIcon:SetTexture("Interface\\GroupFrame\\UI-Group-" .. role .. "Icon")
    frame.roleIcon:SetTexCoord(0, 1, 0, 1)
    frame.roleIcon:Show()
    frame.roleIcon:SetSize(size, size)
  else
    local role = UnitGroupRolesAssigned(frame.unit)
    if frame.optionTable.displayRoleIcon and (role == "TANK" or role == "HEALER" or role == "DAMAGER") then
      frame.roleIcon:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES")
      frame.roleIcon:SetTexCoord(GetTexCoordsForRoleSmallCircle(role))
      frame.roleIcon:Show()
      frame.roleIcon:SetSize(size, size)
    else
      frame.roleIcon:Hide()
      frame.roleIcon:SetSize(1, size)
    end
  end
end

function AddOn:UpdateReadyCheck(frame)
  if frame.readyCheckDecay and GetReadyCheckTimeLeft() <= 0 then
    return
  end

  local readyCheckStatus = GetReadyCheckStatus(frame.unit)
  frame.readyCheckStatus = readyCheckStatus
  if readyCheckStatus == "ready" then
    frame.readyCheckIcon:SetTexture(READY_CHECK_READY_TEXTURE)
    frame.readyCheckIcon:Show()
  elseif readyCheckStatus == "notready" then
    frame.readyCheckIcon:SetTexture(READY_CHECK_NOT_READY_TEXTURE)
    frame.readyCheckIcon:Show()
  elseif readyCheckStatus == "waiting" then
    frame.readyCheckIcon:SetTexture(READY_CHECK_WAITING_TEXTURE)
    frame.readyCheckIcon:Show()
  else
    frame.readyCheckIcon:Hide()
  end
end

function AddOn:FinishReadyCheck(frame)
  if frame:IsVisible() then
    frame.readyCheckDecay = CUF_READY_CHECK_DECAY_TIME

    if frame.readyCheckStatus == "waiting" then -- If you haven't responded, you are not ready.
      frame.readyCheckIcon:SetTexture(READY_CHECK_NOT_READY_TEXTURE)
      frame.readyCheckIcon:Show()
    end
  else
    self:UpdateReadyCheck(frame)
  end
end

function AddOn:CheckReadyCheckDecay(frame, elapsed)
  if frame.readyCheckDecay then
    if frame.readyCheckDecay > 0 then
      frame.readyCheckDecay = frame.readyCheckDecay - elapsed
    else
      frame.readyCheckDecay = nil
      self:UpdateReadyCheck(frame)
    end
  end
end

function AddOn:UpdateCenterStatusIcon(frame)
  if frame.optionTable.displayInOtherGroup and UnitInOtherParty(frame.unit) then
    frame.centerStatusIcon.texture:SetTexture("Interface\\LFGFrame\\LFG-Eye")
    frame.centerStatusIcon.texture:SetTexCoord(0.125, 0.25, 0.25, 0.5)
    frame.centerStatusIcon.border:SetTexture("Interface\\Common\\RingBorder")
    frame.centerStatusIcon.border:Show()
    frame.centerStatusIcon.tooltip = PARTY_IN_PUBLIC_GROUP_MESSAGE
    frame.centerStatusIcon:Show()
  elseif frame.optionTable.displayIncomingResurrect and UnitHasIncomingResurrection(frame.unit) then
    frame.centerStatusIcon.texture:SetTexture("Interface\\RaidFrame\\Raid-Icon-Rez")
    frame.centerStatusIcon.texture:SetTexCoord(0, 1, 0, 1)
    frame.centerStatusIcon.border:Hide()
    frame.centerStatusIcon.tooltip = nil
    frame.centerStatusIcon:Show()
  elseif frame.optionTable.displayIncomingSummon and C_IncomingSummon.HasIncomingSummon(frame.unit) then
    local status = C_IncomingSummon.IncomingSummonStatus(frame.unit)
    if status == Enum.SummonStatus.Pending then
      frame.centerStatusIcon.texture:SetAtlas("Raid-Icon-SummonPending")
      frame.centerStatusIcon.texture:SetTexCoord(0, 1, 0, 1)
      frame.centerStatusIcon.border:Hide()
      frame.centerStatusIcon.tooltip = INCOMING_SUMMON_TOOLTIP_SUMMON_PENDING
      frame.centerStatusIcon:Show()
    elseif status == Enum.SummonStatus.Accepted then
      frame.centerStatusIcon.texture:SetAtlas("Raid-Icon-SummonAccepted")
      frame.centerStatusIcon.texture:SetTexCoord(0, 1, 0, 1)
      frame.centerStatusIcon.border:Hide()
      frame.centerStatusIcon.tooltip = INCOMING_SUMMON_TOOLTIP_SUMMON_ACCEPTED
      frame.centerStatusIcon:Show()
    elseif status == Enum.SummonStatus.Declined then
      frame.centerStatusIcon.texture:SetAtlas("Raid-Icon-SummonDeclined")
      frame.centerStatusIcon.texture:SetTexCoord(0, 1, 0, 1)
      frame.centerStatusIcon.border:Hide()
      frame.centerStatusIcon.tooltip = INCOMING_SUMMON_TOOLTIP_SUMMON_DECLINED
      frame.centerStatusIcon:Show()
    end
  else
    if frame.inDistance and frame.optionTable.displayInOtherPhase then
      local phaseReason = UnitPhaseReason(frame.unit)
      if phaseReason then
        frame.centerStatusIcon.texture:SetTexture("Interface\\TargetingFrame\\UI-PhasingIcon")
        frame.centerStatusIcon.texture:SetTexCoord(0.15625, 0.84375, 0.15625, 0.84375)
        frame.centerStatusIcon.border:Hide()
        frame.centerStatusIcon.tooltip = PartyUtil.GetPhasedReasonString(phaseReason, frame.unit)
        frame.centerStatusIcon:Show()
        return
      end
    end

    frame.centerStatusIcon:Hide()
  end
end

do
  local function SetDebuffsHelper(debuffFrames, frameNum, maxDebuffs, filter, isBossAura, isBossBuff, auras)
    if auras then
      for i = 1, #auras do
        local aura = auras[i]
        if frameNum > maxDebuffs then
          break
        end
        local debuffFrame = debuffFrames[frameNum]
        local index, name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, spellId = aura[1], aura[2], aura[3], aura[4], aura[5], aura[6], aura[7], aura[8], aura[9], aura[10], aura[11]
        local unit
        AddOn:UtilSetDebuff(debuffFrame, unit, index, filter, isBossAura, isBossBuff, name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, spellId)
        frameNum = frameNum + 1

        if isBossAura then
          -- Boss auras are about twice as big as normal debuffs, so we may need to display fewer buffs
          local bossDebuffScale = (debuffFrame.baseSize + BOSS_DEBUFF_SIZE_INCREASE) / debuffFrame.baseSize
          maxDebuffs = maxDebuffs - (bossDebuffScale - 1)
        end
      end
    end
    return frameNum, maxDebuffs
  end

  local function NumElements(arr)
    return arr and #arr or 0
  end

  local dispellableDebuffTypes = { Magic = true, Curse = true, Disease = true, Poison = true }

  -- This interleaves updating buffFrames, debuffFrames and dispelDebuffFrames to reduce the number of calls to UnitAuraSlots/UnitAuraBySlot
  local function UpdateAurasInternal(frame)
    local doneWithBuffs = not frame.buffFrames or not frame.optionTable.displayBuffs or frame.maxBuffs == 0
    local doneWithDebuffs = not frame.debuffFrames or not frame.optionTable.displayDebuffs or frame.maxDebuffs == 0
    local doneWithDispelDebuffs = not frame.dispelDebuffFrames or not frame.optionTable.displayDispelDebuffs or frame.maxDispelDebuffs == 0

    local numUsedBuffs = 0
    local numUsedDebuffs = 0
    local numUsedDispelDebuffs = 0

    local displayOnlyDispellableDebuffs = frame.optionTable.displayOnlyDispellableDebuffs

    -- The following is the priority order for debuffs
    local bossDebuffs, bossBuffs, priorityDebuffs, nonBossDebuffs, nonBossRaidDebuffs
    local index = 1
    local batchCount = frame.maxDebuffs

    if not doneWithDebuffs then
      AuraUtil.ForEachAura(frame.displayedUnit, "HARMFUL", batchCount, function(...)
        if AddOn:Util_IsBossAura(...) then
          if not bossDebuffs then
            bossDebuffs = {}
          end
          tinsert(bossDebuffs, { index, ... })
          numUsedDebuffs = numUsedDebuffs + 1
          if numUsedDebuffs == frame.maxDebuffs then
            doneWithDebuffs = true
            return true
          end
        elseif AddOn.Util_IsPriorityDebuff(...) then
          if not priorityDebuffs then
            priorityDebuffs = {}
          end
          tinsert(priorityDebuffs, { index, ... })
        elseif not displayOnlyDispellableDebuffs and AddOn:Util_ShouldDisplayDebuff(...) then
          if not nonBossDebuffs then
            nonBossDebuffs = {}
          end
          tinsert(nonBossDebuffs, { index, ... })
        end

        index = index + 1
        return false
      end)
    end

    if not doneWithBuffs or not doneWithDebuffs then
      index = 1
      batchCount = math.max(frame.maxDebuffs, frame.maxBuffs)
      AuraUtil.ForEachAura(frame.displayedUnit, "HELPFUL", batchCount, function(...)
        if AddOn:Util_IsBossAura(...) then
          -- Boss Auras are considered Debuffs for our purposes.
          if not doneWithDebuffs then
            if not bossBuffs then
              bossBuffs = {}
            end
            tinsert(bossBuffs, { index, ... })
            numUsedDebuffs = numUsedDebuffs + 1
            if numUsedDebuffs == frame.maxDebuffs then
              doneWithDebuffs = true
            end
          end
        elseif AddOn:UtilShouldDisplayBuff(...) then
          if not doneWithBuffs then
            numUsedBuffs = numUsedBuffs + 1
            local buffFrame = frame.buffFrames[numUsedBuffs]
            AddOn:UtilSetBuff(buffFrame, index, ...)
            if numUsedBuffs == frame.maxBuffs then
              doneWithBuffs = true
            end
          end
        end

        index = index + 1
        return doneWithBuffs and doneWithDebuffs
      end)
    end

    numUsedDebuffs = math.min(frame.maxDebuffs, numUsedDebuffs + NumElements(priorityDebuffs))
    if numUsedDebuffs == frame.maxDebuffs then
      doneWithDebuffs = true
    end

    if not doneWithDispelDebuffs then
      -- Clear what we currently have for dispellable debuffs
      for debuffType, display in pairs(dispellableDebuffTypes) do
        if display then
          frame["hasDispel" .. debuffType] = false
        end
      end
    end

    if not doneWithDispelDebuffs or not doneWithDebuffs then
      batchCount = math.max(frame.maxDebuffs, frame.maxDispelDebuffs)
      index = 1
      AuraUtil.ForEachAura(frame.displayedUnit, "HARMFUL|RAID", batchCount, function(...)
        if not doneWithDebuffs and displayOnlyDispellableDebuffs then
          if AddOn:Util_ShouldDisplayDebuff(...) and not AddOn:Util_IsBossAura(...) and not AddOn.Util_IsPriorityDebuff(...) then
            if not nonBossRaidDebuffs then
              nonBossRaidDebuffs = {}
            end
            tinsert(nonBossRaidDebuffs, { index, ... })
            numUsedDebuffs = numUsedDebuffs + 1
            if numUsedDebuffs == frame.maxDebuffs then
              doneWithDebuffs = true
            end
          end
        end
        if not doneWithDispelDebuffs then
          local debuffType = select(4, ...)
          if dispellableDebuffTypes[debuffType] and not frame["hasDispel" .. debuffType] then
            frame["hasDispel" .. debuffType] = true
            numUsedDispelDebuffs = numUsedDispelDebuffs + 1
            local dispellDebuffFrame = frame.dispelDebuffFrames[numUsedDispelDebuffs]
            AddOn:UtilSetDispelDebuff(dispellDebuffFrame, debuffType, index)
            if numUsedDispelDebuffs == frame.maxDispelDebuffs then
              doneWithDispelDebuffs = true
            end
          end
        end
        index = index + 1
        return (doneWithDebuffs or not displayOnlyDispellableDebuffs) and doneWithDispelDebuffs
      end)
    end

    local frameNum = 1
    local maxDebuffs = frame.maxDebuffs

    do
      local isBossAura = true
      local isBossBuff = false
      frameNum, maxDebuffs = SetDebuffsHelper(frame.debuffFrames, frameNum, maxDebuffs, "HARMFUL", isBossAura, isBossBuff, bossDebuffs)
    end
    do
      local isBossAura = true
      local isBossBuff = true
      frameNum, maxDebuffs = SetDebuffsHelper(frame.debuffFrames, frameNum, maxDebuffs, "HELPFUL", isBossAura, isBossBuff, bossBuffs)
    end
    do
      local isBossAura = false
      local isBossBuff = false
      frameNum, maxDebuffs = SetDebuffsHelper(frame.debuffFrames, frameNum, maxDebuffs, "HARMFUL", isBossAura, isBossBuff, priorityDebuffs)
    end
    do
      local isBossAura = false
      local isBossBuff = false
      frameNum, maxDebuffs = SetDebuffsHelper(frame.debuffFrames, frameNum, maxDebuffs, "HARMFUL|RAID", isBossAura, isBossBuff, nonBossRaidDebuffs)
    end
    do
      local isBossAura = false
      local isBossBuff = false
      frameNum, maxDebuffs = SetDebuffsHelper(frame.debuffFrames, frameNum, maxDebuffs, "HARMFUL", isBossAura, isBossBuff, nonBossDebuffs)
    end
    numUsedDebuffs = frameNum - 1

    AddOn:HideAllBuffs(frame, numUsedBuffs + 1)
    AddOn:HideAllDebuffs(frame, numUsedDebuffs + 1)
    AddOn:HideAllDispelDebuffs(frame, numUsedDispelDebuffs + 1)
  end

  function AddOn:UpdateAuras(frame)
    UpdateAurasInternal(frame)
  end
end

-- Utility Functions
function AddOn:UtilShouldDisplayBuff(...)
  local _, _, _, _, _, _, unitCaster, _, _, spellId, canApplyAura = ...

  local hasCustom, alwaysShowMine, showForMySpec = SpellGetVisibilityInfo(spellId, UnitAffectingCombat("player") and "RAID_INCOMBAT" or "RAID_OUTOFCOMBAT")

  if hasCustom then
    return showForMySpec or (alwaysShowMine and (unitCaster == "player" or unitCaster == "pet" or unitCaster == "vehicle"))
  else
    return (unitCaster == "player" or unitCaster == "pet" or unitCaster == "vehicle") and canApplyAura and not SpellIsSelfBuff(spellId)
  end
end

function AddOn:HideAllBuffs(frame, startingIndex)
  for i = startingIndex or 1, #frame.buffFrames do
    frame.buffFrames[i]:Hide()
  end
end

function AddOn:HideAllDebuffs(frame, startingIndex)
  for i = startingIndex or 1, #frame.debuffFrames do
    frame.debuffFrames[i]:Hide()
  end
end

function AddOn:HideAllDispelDebuffs(frame, startingIndex)
  for i = startingIndex or 1, #frame.dispelDebuffFrames do
    frame.dispelDebuffFrames[i]:Hide()
  end
end

function AddOn:UtilSetBuff(buffFrame, index, ...)
  local _, icon, count, _, duration, expirationTime = ...
  buffFrame.icon:SetTexture(icon)
  if count > 1 then
    local countText = count
    if count >= 100 then
      countText = BUFF_STACKS_OVERFLOW
    end
    buffFrame.count:Show()
    buffFrame.count:SetText(countText)
  else
    buffFrame.count:Hide()
  end
  buffFrame:SetID(index)
  local enabled = expirationTime and expirationTime ~= 0
  if enabled then
    local startTime = expirationTime - duration
    CooldownFrame_Set(buffFrame.cooldown, startTime, duration, true)
  else
    CooldownFrame_Clear(buffFrame.cooldown)
  end
  buffFrame:Show()
end

function AddOn:Util_ShouldDisplayDebuff(...)
  local _, _, _, _, _, _, unitCaster, _, _, spellId = ...

  local hasCustom, alwaysShowMine, showForMySpec = SpellGetVisibilityInfo(spellId, UnitAffectingCombat("player") and "RAID_INCOMBAT" or "RAID_OUTOFCOMBAT")
  if spellId == 25771 then -- Always show Forbearance
    return true
  elseif hasCustom then
    return showForMySpec or alwaysShowMine and (unitCaster == "player" or unitCaster == "pet" or unitCaster == "vehicle")	-- Would only be "mine" in the case of something like forbearance.
  else
    return true
  end
end

function AddOn:Util_IsBossAura(...)
  return select(12, ...)
end

do
  local _, classFilename = UnitClass("player")
  if classFilename == "PALADIN" then
    AddOn.Util_IsPriorityDebuff = function(...)
      local spellId = select(10, ...)
      local isForbearance = spellId == 25771
      return isForbearance or SpellIsPriorityAura(spellId)
    end
  else
    AddOn.Util_IsPriorityDebuff = function(...)
      local spellId = select(10, ...)
      return SpellIsPriorityAura(spellId)
    end
  end
end

function AddOn:UtilSetDebuff(debuffFrame, unit, index, filter, isBossAura, isBossBuff, ...)
  -- make sure you are using the correct index here!
  -- isBossAura says make this look large.
  -- isBossBuff looks in HELPFULL auras otherwise it looks in HARMFULL ones
  local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, _, spellId = ...
  if name == nil then
    -- for backwards compatibility - this functionality will be removed in a future update
    if unit then
      if isBossBuff then
        name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, _, spellId = UnitBuff(unit, index, filter)
      else
        name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, _, spellId = UnitDebuff(unit, index, filter)
      end
    else
      return
    end
  end
  debuffFrame.filter = filter
  debuffFrame.icon:SetTexture(icon)
  if count > 1 then
    local countText = count
    if count >= 100 then
      countText = BUFF_STACKS_OVERFLOW
    end
    debuffFrame.count:Show()
    debuffFrame.count:SetText(countText)
  else
    debuffFrame.count:Hide()
  end
  debuffFrame:SetID(index)
  local enabled = expirationTime and expirationTime ~= 0
  if enabled then
    local startTime = expirationTime - duration
    CooldownFrame_Set(debuffFrame.cooldown, startTime, duration, true)
  else
    CooldownFrame_Clear(debuffFrame.cooldown)
  end

  local color = DebuffTypeColor[debuffType] or DebuffTypeColor["none"]
  debuffFrame.border:SetVertexColor(color.r, color.g, color.b)

  debuffFrame.isBossBuff = isBossBuff
  if isBossAura then
    local size = min(debuffFrame.baseSize + BOSS_DEBUFF_SIZE_INCREASE, debuffFrame.maxHeight)
    debuffFrame:SetSize(size, size)
  else
    debuffFrame:SetSize(debuffFrame.baseSize, debuffFrame.baseSize)
  end

  debuffFrame:Show()
end

function AddOn:UtilSetDispelDebuff(dispellDebuffFrame, debuffType, index)
  dispellDebuffFrame:Show()
  dispellDebuffFrame.icon:SetTexture("Interface\\RaidFrame\\Raid-Icon-Debuff" .. debuffType)
  dispellDebuffFrame:SetID(index)
end

-- Dropdown
function AddOn:DropDown_Initialize()
  local unit = self:GetParent().unit
  if not unit then
    return
  end
  local menu
  local name
  local id
  if UnitIsUnit(unit, "player") then
    menu = "SELF"
  elseif UnitIsUnit(unit, "vehicle") then
    -- NOTE: vehicle check must come before pet check for accuracy's sake because
    -- a vehicle may also be considered your pet
    menu = "VEHICLE"
  elseif UnitIsUnit(unit, "pet") then
    menu = "PET"
  elseif UnitIsPlayer(unit) then
    id = UnitInRaid(unit)
    if id then
      menu = "RAID_PLAYER"
    elseif UnitInParty(unit) then
      menu = "PARTY"
    else
      menu = "PLAYER"
    end
  else
    menu = "TARGET"
    name = RAID_TARGET_ICON
  end
  --TODO: This play a sound whenever someone join the group.
  if menu then
    UnitPopup_ShowMenu(self, menu, unit, name, id)
  end
end

------ The default setup function
local texCoords = {
  ["Raid-AggroFrame"] = {  0.00781250, 0.55468750, 0.00781250, 0.27343750 },
  ["Raid-TargetFrame"] = { 0.00781250, 0.55468750, 0.28906250, 0.55468750 },
}

local NATIVE_UNIT_FRAME_HEIGHT = 36
local NATIVE_UNIT_FRAME_WIDTH = 72

function AddOn.DefaultSetup(frame, groupType)
  AddOn.DefaultSetupOptions = {
    displayPowerBar = true,
    height = AddOn:GetHeight(groupType or GetNumGroupMembers()),
    width = AddOn:GetWidth(groupType or GetNumGroupMembers()),
    displayBorder = false
  }
  local options = AddOn.DefaultSetupOptions
  --options.width = frame:GetWidth()
  --options.height = frame:GetHeight()
  local componentScale = min(options.height / NATIVE_UNIT_FRAME_HEIGHT, options.width / NATIVE_UNIT_FRAME_WIDTH)

  frame:SetAlpha(1)

  frame:SetSize(options.width, options.height)
  local powerBarHeight = 8
  local powerBarUsedHeight = options.displayPowerBar and powerBarHeight or 0

  frame.background:SetTexture("Interface\\RaidFrame\\Raid-Bar-Hp-Bg")
  frame.background:SetTexCoord(0, 1, 0, 0.53125)
  frame.healthBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 1, -1)

  frame.healthBar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -1, 1 + powerBarUsedHeight)

  frame.healthBar:SetStatusBarTexture("Interface\\RaidFrame\\Raid-Bar-Hp-Fill", "BORDER")

  if options.displayPowerBar then
    if options.displayBorder then
      frame.powerBar:SetPoint("TOPLEFT", frame.healthBar, "BOTTOMLEFT", 0, -2)
    else
      frame.powerBar:SetPoint("TOPLEFT", frame.healthBar, "BOTTOMLEFT", 0, 0)
    end
    frame.powerBar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -1, 1)
    frame.powerBar:SetStatusBarTexture("Interface\\RaidFrame\\Raid-Bar-Resource-Fill", "BORDER")
    frame.powerBar.background:SetTexture("Interface\\RaidFrame\\Raid-Bar-Resource-Background")
    frame.powerBar:Show()
  else
    frame.powerBar:Hide()
  end

  frame.myHealPrediction:ClearAllPoints()
  frame.myHealPrediction:SetColorTexture(1, 1, 1)
  frame.myHealPrediction:SetGradient("VERTICAL", 8/255, 93/255, 72/255, 11/255, 136/255, 105/255)
  frame.myHealAbsorb:ClearAllPoints()
  frame.myHealAbsorb:SetTexture("Interface\\RaidFrame\\Absorb-Fill", true, true)
  frame.myHealAbsorbLeftShadow:ClearAllPoints()
  frame.myHealAbsorbRightShadow:ClearAllPoints()
  frame.otherHealPrediction:ClearAllPoints()
  frame.otherHealPrediction:SetColorTexture(1, 1, 1)
  frame.otherHealPrediction:SetGradient("VERTICAL", 11/255, 53/255, 43/255, 21/255, 89/255, 72/255)
  frame.totalAbsorb:ClearAllPoints()
  frame.totalAbsorb:SetTexture("Interface\\RaidFrame\\Shield-Fill")
  frame.totalAbsorb.overlay = frame.totalAbsorbOverlay
  frame.totalAbsorbOverlay:SetTexture("Interface\\RaidFrame\\Shield-Overlay", true, true) -- Tile both vertically and horizontally
  frame.totalAbsorbOverlay:SetAllPoints(frame.totalAbsorb)
  frame.totalAbsorbOverlay.tileSize = 32
  frame.overAbsorbGlow:ClearAllPoints()
  frame.overAbsorbGlow:SetTexture("Interface\\RaidFrame\\Shield-Overshield")
  frame.overAbsorbGlow:SetBlendMode("ADD")
  frame.overAbsorbGlow:SetPoint("BOTTOMLEFT", frame.healthBar, "BOTTOMRIGHT", -7, 0)
  frame.overAbsorbGlow:SetPoint("TOPLEFT", frame.healthBar, "TOPRIGHT", -7, 0)
  frame.overAbsorbGlow:SetWidth(16)
  frame.overHealAbsorbGlow:ClearAllPoints()
  frame.overHealAbsorbGlow:SetTexture("Interface\\RaidFrame\\Absorb-Overabsorb")
  frame.overHealAbsorbGlow:SetBlendMode("ADD")
  frame.overHealAbsorbGlow:SetPoint("BOTTOMRIGHT", frame.healthBar, "BOTTOMLEFT", 7, 0)
  frame.overHealAbsorbGlow:SetPoint("TOPRIGHT", frame.healthBar, "TOPLEFT", 7, 0)
  frame.overHealAbsorbGlow:SetWidth(16)

  frame.roleIcon:ClearAllPoints()
  frame.roleIcon:SetPoint("TOPLEFT", 3, -2)
  frame.roleIcon:SetSize(12, 12)

  frame.name:SetPoint("TOPLEFT", frame.roleIcon, "TOPRIGHT", 0, -1)
  frame.name:SetPoint("TOPRIGHT", -3, -3)
  frame.name:SetJustifyH("LEFT")

  local NATIVE_FONT_SIZE = 12
  local fontName, _, fontFlags = frame.statusText:GetFont()
  frame.statusText:SetFont(fontName, NATIVE_FONT_SIZE * componentScale, fontFlags)
  frame.statusText:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 3, options.height / 3 - 2)
  frame.statusText:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, options.height / 3 - 2)
  frame.statusText:SetHeight(12 * componentScale)

  local readyCheckSize = 15 * componentScale
  frame.readyCheckIcon:ClearAllPoints()
  frame.readyCheckIcon:SetPoint("BOTTOM", frame, "BOTTOM", 0, options.height / 3 - 4)
  frame.readyCheckIcon:SetSize(readyCheckSize, readyCheckSize)

  local buffSize = 11 * componentScale

  AddOn:SetMaxBuffs(frame, 3)
  AddOn:SetMaxDebuffs(frame, 3)
  AddOn:SetMaxDispelDebuffs(frame, 3)

  local buffPos, buffRelativePoint, buffOffset = "BOTTOMRIGHT", "BOTTOMLEFT", CUF_AURA_BOTTOM_OFFSET + powerBarUsedHeight
  frame.buffFrames[1]:ClearAllPoints()
  frame.buffFrames[1]:SetPoint(buffPos, frame, "BOTTOMRIGHT", -3, buffOffset)
  for i = 1, #frame.buffFrames do
    if i > 1 then
      frame.buffFrames[i]:ClearAllPoints()
      frame.buffFrames[i]:SetPoint(buffPos, frame.buffFrames[i - 1], buffRelativePoint, 0, 0)
    end
    frame.buffFrames[i]:SetSize(buffSize, buffSize)
  end

  local debuffPos, debuffRelativePoint, debuffOffset = "BOTTOMLEFT", "BOTTOMRIGHT", CUF_AURA_BOTTOM_OFFSET + powerBarUsedHeight
  frame.debuffFrames[1]:ClearAllPoints()
  frame.debuffFrames[1]:SetPoint(debuffPos, frame, "BOTTOMLEFT", 3, debuffOffset)
  for i = 1, #frame.debuffFrames do
    if i > 1 then
      frame.debuffFrames[i]:ClearAllPoints()
      frame.debuffFrames[i]:SetPoint(debuffPos, frame.debuffFrames[i - 1], debuffRelativePoint, 0, 0)
    end
    frame.debuffFrames[i].baseSize = buffSize
    frame.debuffFrames[i].maxHeight = options.height - powerBarUsedHeight - CUF_AURA_BOTTOM_OFFSET - CUF_NAME_SECTION_SIZE
  end

  frame.dispelDebuffFrames[1]:SetPoint("TOPRIGHT", -3, -2)
  for i = 1, #frame.dispelDebuffFrames do
    if i > 1 then
      frame.dispelDebuffFrames[i]:SetPoint("RIGHT", frame.dispelDebuffFrames[i - 1], "LEFT", 0, 0)
    end
    frame.dispelDebuffFrames[i]:SetSize(12, 12)
  end

  frame.selectionHighlight:SetTexture("Interface\\RaidFrame\\Raid-FrameHighlights")
  frame.selectionHighlight:SetTexCoord(unpack(texCoords["Raid-TargetFrame"]))
  frame.selectionHighlight:SetAllPoints(frame)

  frame.aggroHighlight:SetTexture("Interface\\RaidFrame\\Raid-FrameHighlights")
  frame.aggroHighlight:SetTexCoord(unpack(texCoords["Raid-AggroFrame"]))
  frame.aggroHighlight:SetAllPoints(frame)

  frame.centerStatusIcon:ClearAllPoints()
  frame.centerStatusIcon:SetPoint("CENTER", frame, "BOTTOM", 0, options.height / 3 + 2)
  frame.centerStatusIcon:SetSize(buffSize * 2, buffSize * 2)

  if options.displayBorder then
    frame.horizTopBorder:ClearAllPoints()
    frame.horizTopBorder:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, -7)
    frame.horizTopBorder:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, -7)
    frame.horizTopBorder:SetTexture("Interface\\RaidFrame\\Raid-HSeparator")
    frame.horizTopBorder:SetHeight(8)
    frame.horizTopBorder:Show()

    frame.horizBottomBorder:ClearAllPoints()
    frame.horizBottomBorder:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 1)
    frame.horizBottomBorder:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", 0, 1)
    frame.horizBottomBorder:SetTexture("Interface\\RaidFrame\\Raid-HSeparator")
    frame.horizBottomBorder:SetHeight(8)
    frame.horizBottomBorder:Show()

    frame.vertLeftBorder:ClearAllPoints()
    frame.vertLeftBorder:SetPoint("TOPRIGHT", frame, "TOPLEFT", 7, 0)
    frame.vertLeftBorder:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", 7, 0)
    frame.vertLeftBorder:SetTexture("Interface\\RaidFrame\\Raid-VSeparator")
    frame.vertLeftBorder:SetWidth(8)
    frame.vertLeftBorder:Show()

    frame.vertRightBorder:ClearAllPoints()
    frame.vertRightBorder:SetPoint("TOPLEFT", frame, "TOPRIGHT", -1, 0)
    frame.vertRightBorder:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", -1, 0)
    frame.vertRightBorder:SetTexture("Interface\\RaidFrame\\Raid-VSeparator")
    frame.vertRightBorder:SetWidth(8)
    frame.vertRightBorder:Show()

    if options.displayPowerBar then
      frame.horizDivider:ClearAllPoints()
      frame.horizDivider:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 1 + powerBarUsedHeight)
      frame.horizDivider:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", 0, 1 + powerBarUsedHeight)
      frame.horizDivider:SetTexture("Interface\\RaidFrame\\Raid-HSeparator")
      frame.horizDivider:SetHeight(8)
      frame.horizDivider:Show()
    else
      frame.horizDivider:Hide()
    end
  else
    frame.horizTopBorder:Hide()
    frame.horizBottomBorder:Hide()
    frame.vertLeftBorder:Hide()
    frame.vertRightBorder:Hide()

    frame.horizDivider:Hide()
  end

  AddOn:SetOptionTable(frame, AddOn.db.profile)
end

function AddOn:CreateOrUpdateHeaders()
  oUF:SetActiveStyle("RaidFrames")
  -- TODO: Find a way to have separated columns for each group.
  --[[
  List of the various configuration attributes
  ======================================================
  showRaid = [BOOLEAN] -- true if the header should be shown while in a raid
  showParty = [BOOLEAN] -- true if the header should be shown while in a party and not in a raid
  showPlayer = [BOOLEAN] -- true if the header should show the player when not in a raid
  showSolo = [BOOLEAN] -- true if the header should be shown while not in a group (implies showPlayer)
  nameList = [STRING] -- a comma separated list of player names (not used if 'groupFilter' is set)
  groupFilter = [1-8, STRING] -- a comma seperated list of raid group numbers and/or uppercase class names and/or uppercase roles
  roleFilter = [STRING] -- a comma seperated list of MT/MA/Tank/Healer/DPS role strings
  strictFiltering = [BOOLEAN]
  -- if true, then
  ---- if only groupFilter is specified then characters must match both a group and a class from the groupFilter list
  ---- if only roleFilter is specified then characters must match at least one of the specified roles
  ---- if both groupFilter and roleFilters are specified then characters must match a group and a class from the groupFilter list and a role from the roleFilter list
  point = [STRING] -- a valid XML anchoring point (Default: "TOP")
  xOffset = [NUMBER] -- the x-Offset to use when anchoring the unit buttons (Default: 0)
  yOffset = [NUMBER] -- the y-Offset to use when anchoring the unit buttons (Default: 0)
  sortMethod = ["INDEX", "NAME", "NAMELIST"] -- defines how the group is sorted (Default: "INDEX")
  sortDir = ["ASC", "DESC"] -- defines the sort order (Default: "ASC")
  template = [STRING] -- the XML template to use for the unit buttons
  templateType = [STRING] - specifies the frame type of the managed subframes (Default: "Button")
  groupBy = [nil, "GROUP", "CLASS", "ROLE", "ASSIGNEDROLE"] - specifies a "grouping" type to apply before regular sorting (Default: nil)
  groupingOrder = [STRING] - specifies the order of the groupings (ie. "1,2,3,4,5,6,7,8")
  maxColumns = [NUMBER] - maximum number of columns the header will create (Default: 1)
  unitsPerColumn = [NUMBER or nil] - maximum units that will be displayed in a singe column, nil is infinite (Default: nil)
  startingIndex = [NUMBER] - the index in the final sorted unit list at which to start displaying units (Default: 1)
  columnSpacing = [NUMBER] - the amount of space between the rows/columns (Default: 0)
  columnAnchorPoint = [STRING] - the anchor point of each new column (ie. use LEFT for the columns to grow to the right)
  --]]

  --"roleFilter", "MAINTANK,MAINASSIS T,TANK,HEALER,DAMAGER,NONE",
  --"groupFilter", "WARRIOR,DEATHKNIGHT,PALADIN,MONK,PRIEST,SHAMAN,DRUID,ROGUE,MAGE,WARLOCK,HUNTER,DEMONHUNTER",

  --local isDamager = ElvDB and ElvDB.profileKeys and ElvDB.profileKeys[ElvUI[1].mynameRealm] == "Meivyn"

  if not self.headers then
    self.headers = {}
  end

  if AddOn.db.profile.displayPartyGroup then
  -- Party (1 to 5 players)
  local party = oUF:SpawnHeader("oUF_Party", nil, "custom [@raid6,exists] hide; show",
    "showRaid", true,
    "showParty", true,
    "showPlayer", true,
    "point", "LEFT",
    "sortMethod", "NAME",
    "groupBy", "ASSIGNEDROLE",
    "groupingOrder", "TANK,HEALER,DAMAGER,NONE",
  --"maxColumns", 5,
  --"unitsPerColumn", 1,
  --"columnAnchorPoint", "TOP",
    "columnAnchorPoint", character == "Meivyn" and "TOP" or "LEFT",
    "oUF-initialConfigFunction", format('self:SetWidth(%d); self:SetHeight(%d);', AddOn:GetWidth("party"), AddOn:GetHeight("party"))
    )
  if isDamager then
    party:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", 757, 200)
  else
    --party:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", 757, 258)
    party:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", AddOn.db.profile.offsetX, AddOn.db.profile.offsetY)
  end
  AddOn.headers.party = party
  end
  -- Raid 20 (6 to 20 players)
  local raid20 = oUF:SpawnHeader("oUF_Raid20", nil, "custom [@raid6,noexists][@raid21,exists] hide; show",
    "showRaid", true,
    "showParty", false,
    "showPlayer", true,
    "sortMethod", "NAME",
    "groupBy", "ASSIGNEDROLE",
    "groupingOrder", "TANK,DAMAGER,HEALER,NONE",
    "maxColumns", 4,
    "unitsPerColumn", 5,
    "columnAnchorPoint", "LEFT",
    "oUF-initialConfigFunction", format('self:SetWidth(%d); self:SetHeight(%d);', AddOn:GetWidth("raid20"), AddOn:GetHeight("raid20"))
  )
  if character == "Meivyn" then
    raid20:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", 4, 516)
  else
    --raid20:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", 758, 258)
    raid20:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", AddOn.db.profile.offsetX, AddOn.db.profile.offsetY)
  end
  AddOn.headers.raid20 = raid20
  -- Raid 25 (21 to 25 players)
  local raid25 = oUF:SpawnHeader("oUF_Raid25", nil, "custom [@raid21,noexists][@raid26,exists] hide; show",
    "showRaid", true,
    "showParty", false,
    "showPlayer", true,
    "sortMethod", "NAME",
    "groupBy", "ASSIGNEDROLE",
    "groupingOrder", "TANK,DAMAGER,HEALER,NONE",
    "maxColumns", 5,
    "unitsPerColumn", 5,
    "columnAnchorPoint", "LEFT",
    "oUF-initialConfigFunction", format('self:SetWidth(%d); self:SetHeight(%d);', AddOn:GetWidth("raid25"), AddOn:GetHeight("raid25"))
  )
  if character == "Meivyn" then
  else
    --raid25:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", 757, 258)
    raid25:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", AddOn.db.profile.offsetX, AddOn.db.profile.offsetY)
  end
  AddOn.headers.raid25 = raid25
  -- Raid 40 (26 to 40 players)
  local raid40 = oUF:SpawnHeader("oUF_Raid40", nil, "custom [@raid26,noexists] hide; show",
    "showRaid", true,
    "showParty", false,
    "showPlayer", true,
    "point", "LEFT",
    "sortMethod", "NAME",
    "groupBy", "ASSIGNEDROLE",
    "groupingOrder", "TANK,DAMAGER,HEALER,NONE",
    "maxColumns", 8,
    "unitsPerColumn", 5,
    "columnAnchorPoint", "TOP",
    "oUF-initialConfigFunction", format('self:SetWidth(%d); self:SetHeight(%d);', AddOn:GetWidth("raid40"), AddOn:GetHeight("raid40"))
  )
  if character == "Meivyn" then
  else
    --raid40:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", 757, 258)
    raid40:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", AddOn.db.profile.offsetX, AddOn.db.profile.offsetY)
  end
  AddOn.headers.raid40 = raid40
end

oUF:RegisterStyle("RaidFrames", AddOn.ConstructFrames)
oUF:Factory(function(self)
    AddOn:CreateOrUpdateHeaders()
end)

function AddOn:GetWidth(groupSizeOrType)
  local width
  if type(groupSizeOrType) == "number" then
    width = math.floor(self.db.profile.width / ((groupSizeOrType <= 5 or groupSizeOrType > 20) and 5 or 4))
  else
    width = math.floor(self.db.profile.width / (groupSizeOrType == "raid20" and 4 or 5) + 0.5)
  end
  return width
end

function AddOn:GetHeight(groupSizeOrType)
  local height
  if type(groupSizeOrType) == "number" then
    height = math.floor(self.db.profile.height / (groupSizeOrType > 25 and 8 or 5))
  else
    height = math.floor(self.db.profile.height / (groupSizeOrType == "raid40" and 8 or 5) + 0.5)
  end
  return height
end

--local resetHeader = self:SpawnHeader("RaidFrames", nil, "raid,party",
--  "showRaid", true,
--  "showParty", true,
--  "showPlayer", true,
--  "showSolo", true,
--  "nameList", nil,
--  "groupFilter", nil,
--  "roleFilter", nil,
--  "strictFiltering", nil,
--  "point", "LEFT",
--  "xOffset", nil,
--  "yOffset", nil,
--  "sortMethod", "NAME",
--  "sortDir", nil,
--  "groupBy", nil,
--  "groupingOrder", nil,
--  "maxColumns", nil,
--  "unitsPerColumn", nil,
--  "startingIndex", nil,
--  "columnSpacing", nil,
--  "columnAnchorPoint", nil,
--  "oUF-initialConfigFunction", ([[
--      --self:SetWidth(271) -- 81.2
--      --self:SetHeight(51) -- 50.6
--      self:SetWidth(81) -- 81.2
--      self:SetHeight(51) -- 50.6
--    ]])
--)
--header:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", 757, 258)
