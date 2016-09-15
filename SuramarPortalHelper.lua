local SPH_MapTooltip
local portalMap = {}
local loaded = true;



local eventResponseFrame = CreateFrame("Frame", "Helper")
	eventResponseFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	eventResponseFrame:RegisterEvent("ADDON_LOADED");
	eventResponseFrame:RegisterEvent("WORLD_MAP_UPDATE")
	eventResponseFrame:RegisterEvent("WORLD_MAP_NAME_UPDATE")
	
	
	local function eventHandler(self, event, arg1 , arg2, arg3, arg4, arg5)
		if (event == "ADDON_LOADED") then
			if loaded then
				loaded = false;
				SPH_MapTooltipSetup();
				SPH_createMap();
				--print("SPH loaded")
			end
		else
			local _, _, _, isMicroDungeon, microDungeonMapName = GetMapInfo();
			if GetCurrentMapAreaID() == 1033 and not isMicroDungeon then --Suramar 
				SPH_ShowPortals(true)
				--print("showing (zone "..GetCurrentMapAreaID()..")")
			else
				SPH_ShowPortals(false)
				--print("hiding (zone "..GetCurrentMapAreaID()..")")
			end
			
			--[[if isMicroDungeon and microDungeonMapName == "FalanaarTunnels" then
				SPH_ShowPortals(false)
				print("is in FalanaarTunnels") --41, 13.69
			end]]--
		end
	end
	
	eventResponseFrame:SetScript("OnEvent", eventHandler);
	
	
	


function SPH_createLoc(x, y, position)
	local portal = CreateFrame("Frame", "Portal", WorldMapDetailFrame)

	portal.Texture = portal:CreateTexture()
	portal.Texture:SetTexture("Interface\\Icons\\spell_arcane_teleportdarnassus")
	portal.Texture:SetAllPoints()
	portal:EnableMouse(true)
	portal:SetFrameStrata("TOOLTIP")
	portal:SetFrameLevel(WorldMapDetailFrame:GetFrameLevel()+10)
	
	
	portal:SetPoint("CENTER", WorldMapDetailFrame, "TOPLEFT", (x / 100) * WorldMapDetailFrame:GetWidth(), (-y / 100) * WorldMapDetailFrame:GetHeight())

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
	portalMap[#portalMap+1] = portal;
end

function SPH_ShowPortals(bool)
	for i = 1, #portalMap do
		if bool then
			portalMap[i]:Show();
		else
			portalMap[i]:Hide();
		end
	end
end


function SPH_MapTooltipSetup()
	SPH_MapTooltip = CreateFrame("GameTooltip", "SPH_MapTooltip", WorldMapFrame, "GameTooltipTemplate")
	SPH_MapTooltip:SetFrameStrata("TOOLTIP")
	SPH_MapTooltip:SetFrameLevel(WorldMapDetailFrame:GetFrameLevel()+20)
	WorldMapFrame:HookScript("OnSizeChanged",
		function(self)
			SPH_MapTooltip:SetScale(1/self:GetScale())
		end
	)
end

function SPH_createMap()
	SPH_createLoc(30.8, 10.9, "Moon Guard\no|cFFFF0000o|ro oooo\no           o");
	SPH_createLoc(36.2, 47.1, "Ruins of Elune'eth\nooo |cFFFF0000o|rooo\no           o")
	SPH_createLoc(21.5, 29.9, "Falanaar\n|cFFFF0000o|roo oooo\no           o")
	SPH_createLoc(47.5, 82.0, "The Waning Crescent\nooo o|cFFFF0000o|roo\no           o")
	SPH_createLoc(64.0, 60.4, "Twilight Vineyards\nooo oooo\no           |cFFFF0000o|r")
	SPH_createLoc(39.1, 76.3, "Felsoul Hold (Cave)\n|cFFFF0000o|roo oooo\no           o")
	SPH_createLoc(43.6, 79.1, "Lunastre Estate\noo|cFFFF0000o|r oooo\no           o")
	SPH_createLoc(43.4, 60.7, "Sanctum of Order\nooo oo|cFFFF0000o|ro\no           o")
	SPH_createLoc(42.2, 35.4, "Tel'anor\nooo ooo|cFFFF0000o|r\no           o")
end