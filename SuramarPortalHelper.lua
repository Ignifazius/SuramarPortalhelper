local SPH_MapTooltip
local portalMap = {}
local loaded = true
local falanaarPortal
local felsoulHoldPortal

local eventResponseFrame = CreateFrame("Frame", "Helper")
	--eventResponseFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	eventResponseFrame:RegisterEvent("ZONE_CHANGED")
	eventResponseFrame:RegisterEvent("ADDON_LOADED")
    --eventResponseFrame:RegisterEvent("NEW_WMO_CHUNK")
    --eventResponseFrame:RegisterEvent("MAP_EXPLORATION_UPDATED")
    --eventResponseFrame:RegisterEvent("MINIMAP_UPDATE_TRACKING")
    --eventResponseFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
	--eventResponseFrame:RegisterEvent("WORLD_MAP_UPDATE")
	--eventResponseFrame:RegisterEvent("WORLD_MAP_NAME_UPDATE")
	--eventResponseFrame:RegisterEvent("QUEST_QUERY_COMPLETE")
	
	
	local function eventHandler(self, event, arg1 , arg2, arg3, arg4, arg5)
    --print(event)
		if (event == "ADDON_LOADED" and arg1 == "SuramarPortalHelper") then
			SPH_MapTooltipSetup();
			SPH_createMap();
		else
            --local locID = C_Map.GetBestMapForUnit("player")
			--local _, _, _, isMicroDungeon, microDungeonMapName = C_Map.GetMapInfo()
			SPH_HideAllPortals()
			if WorldMapFrame:GetMapID() == 680 then -- player is in Suramar 
				SPH_ShowPortals(true)
			elseif WorldMapFrame:GetMapID() == 684 then -- FalanaarTunnels
				SPH_ShowFalanaar(true)
			elseif WorldMapFrame:GetMapID() == 682 then -- SuramarLegionScar
				SPH_ShowFelsoulHold(true)				
			end		
		end
		SPH_updateMarker();
	end
	
	eventResponseFrame:SetScript("OnEvent", eventHandler);
	
function SPH_createLoc(x, y, position)
	local portal = CreateFrame("Frame", "Portal", WorldMapFrame)

	portal.Texture = portal:CreateTexture()
	portal.Texture:SetTexture("Interface\\Icons\\spell_arcane_teleportdarnassus")
	portal.Texture:SetAllPoints()
	portal:EnableMouse(true)
	portal:SetFrameStrata("TOOLTIP")
	portal:SetFrameLevel(WorldMapFrame:GetFrameLevel()+10)
		
	portal:SetPoint("CENTER", WorldMapFrame.ScrollContainer, "TOPLEFT", (x / 100) * WorldMapFrame.ScrollContainer:GetWidth(), (-y / 100) * WorldMapFrame.ScrollContainer:GetHeight())

	portal:SetWidth(15)
	portal:SetHeight(15)
	
	portal:HookScript("OnEnter",
		function(pin, motion)
			SPH_MapTooltip:SetOwner(pin, "ANCHOR_RIGHT")
			SPH_MapTooltip:ClearLines()
			SPH_MapTooltip:SetScale(WorldMapFrame:GetScale())
			SPH_MapTooltip:AddLine(position)
			SPH_MapTooltip:Show()
		end
	)
	portal:HookScript("OnLeave",
		function()
			SPH_MapTooltip:Hide()
		end
	)	
	portal:Hide()
	return portal
end

function SPH_HideAllPortals()
	SPH_ShowPortals(false)
	SPH_ShowFalanaar(false)
	SPH_ShowFelsoulHold(false)	
end

function SPH_ShowPortals(bool)
	for i = 1, #portalMap do
		if bool then
			portalMap[i]:Show()
		else
			portalMap[i]:Hide()
		end
	end
end

function SPH_ShowFalanaar(bool)
	if bool then
		falanaarPortal:Show()
	else
		falanaarPortal:Hide()
	end
end

function SPH_ShowFelsoulHold(bool)
	if bool then
		felsoulHoldPortal:Show()
	else
		felsoulHoldPortal:Hide()
	end
end

function SPH_MapTooltipSetup()
	SPH_MapTooltip = CreateFrame("GameTooltip", "SPH_MapTooltip", WorldMapFrame, "GameTooltipTemplate")
	SPH_MapTooltip:SetFrameStrata("TOOLTIP")
	SPH_MapTooltip:SetFrameLevel(WorldMapFrame:GetFrameLevel()+20)
	WorldMapFrame:HookScript("OnSizeChanged",
		function(self)
			SPH_MapTooltip:SetScale(1/self:GetScale())
		end
	)
end

function SPH_updateMarker()
	if (loaded and C_QuestLog.IsQuestFlaggedCompleted(42889)) then
		loaded = false
		if GetLocale() == "deDE" then
			portalMap[4] = SPH_createLoc(52.0, 78.75, "Immermond Terrasse\noo oo|cFFFF0000o|r oo\no            o");
		else
			portalMap[4] = SPH_createLoc(52.0, 78.75, "Evermoon Terrace\noo oo|cFFFF0000o|r oo\no            o");
		end
	end
end


function SPH_createMap()
	if GetLocale() == "deDE" then
		portalMap[#portalMap+1] = SPH_createLoc(30.8, 10.9, "Mondwachenfestung\n o|cFFFF0000o|r ooo oo\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(36.2, 47.1, "Ruinen von Elune'eth\n oo o|cFFFF0000o|ro oo\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(21.5, 29.9, "Falanaar\n |cFFFF0000o|ro ooo oo\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(47.5, 82.0, "Mondsichelforum\n oo oo|cFFFF0000o|r oo\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(64.0, 60.4, "Zwielichtrebgärten\n oo ooo oo\n o          o|cFFFF0000o|r")
		portalMap[#portalMap+1] = SPH_createLoc(39.1, 76.3, "Teufelsseelenbastion\n oo ooo oo\n |cFFFF0000o|r          oo")
		portalMap[#portalMap+1] = SPH_createLoc(43.6, 79.1, "Anwesen der Lunastres\n oo |cFFFF0000o|roo oo\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(43.4, 60.7, "Sanktum der Ordnung\n oo ooo |cFFFF0000o|ro\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(42.2, 35.4, "Tel'anor\n oo ooo o|cFFFF0000o|r\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(55.5, 69.4, "Hafen der Astravar\n oo ooo oo\n o          |cFFFF0000o|ro")
		falanaarPortal = SPH_createLoc(40.84, 13.44, "Zurück zur Basis.")
		felsoulHoldPortal = SPH_createLoc(53.64, 36.75, "Zurück zur Basis.")
	elseif (GetLocale() == "esES" or GetLocale() == "esMX") then
		portalMap[#portalMap+1] = SPH_createLoc(30.8, 10.9, "Bastión de la Guadia Lunar\n o|cFFFF0000o|r ooo oo\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(36.2, 47.1, "Ruinas de Elune'eth\n oo o|cFFFF0000o|ro oo\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(21.5, 29.9, "Falanaar\n |cFFFF0000o|ro ooo oo\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(47.5, 82.0, "El Creciente Menguante\n oo oo|cFFFF0000o|r oo\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(64.0, 60.4, "Viñedos Crepusculares\n oo ooo oo\n o          o|cFFFF0000o|r")
		portalMap[#portalMap+1] = SPH_createLoc(39.1, 76.3, "Bastión Alma Vil\n oo ooo oo\n |cFFFF0000o|r          oo")
		portalMap[#portalMap+1] = SPH_createLoc(43.6, 79.1, "Finca de Lunastre\n oo |cFFFF0000o|roo oo\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(43.4, 60.7, "Santuario del Orden\n oo ooo |cFFFF0000o|ro\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(42.2, 35.4, "Tel'anor\n oo ooo o|cFFFF0000o|r\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(55.5, 69.4, "Puerto de los Astravar\n oo ooo oo\n o          |cFFFF0000o|ro")
		falanaarPortal = SPH_createLoc(40.84, 13.44, "Retorno a base.")
		felsoulHoldPortal = SPH_createLoc(53.64, 36.75, "Retorno a base.")
	else 
		portalMap[#portalMap+1] = SPH_createLoc(30.8, 10.9, "Moon Guard\n o|cFFFF0000o|r ooo oo\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(36.2, 47.1, "Ruins of Elune'eth\n oo o|cFFFF0000o|ro oo\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(21.5, 29.9, "Falanaar\n |cFFFF0000o|ro ooo oo\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(47.5, 82.0, "The Waning Crescent\n oo oo|cFFFF0000o|r oo\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(64.0, 60.4, "Twilight Vineyards\n oo ooo oo\n o          o|cFFFF0000o|r")
		portalMap[#portalMap+1] = SPH_createLoc(39.1, 76.3, "Felsoul Hold\n oo ooo oo\n |cFFFF0000o|r          oo")
		portalMap[#portalMap+1] = SPH_createLoc(43.6, 79.1, "Lunastre Estate\n oo |cFFFF0000o|roo oo\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(43.4, 60.7, "Sanctum of Order\n oo ooo |cFFFF0000o|ro\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(42.2, 35.4, "Tel'anor\n oo ooo o|cFFFF0000o|r\n o          oo")
		portalMap[#portalMap+1] = SPH_createLoc(55.5, 69.4, "Astravar Harbor\n oo ooo oo\n o          |cFFFF0000o|ro")
		falanaarPortal = SPH_createLoc(40.84, 13.44, "Return to base.")
		felsoulHoldPortal = SPH_createLoc(53.64, 36.75, "Return to base.")
	end
end