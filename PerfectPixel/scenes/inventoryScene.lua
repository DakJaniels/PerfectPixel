local PP = PP ---@class PP
local namespace	= 'InventoryScene'

PP.inventoryScene = function()
    if SCENE_MANAGER:IsCurrentSceneGamepad() then return end
	--===============================================================================================--
	local sv, def = PP:AddNewSavedVars(0.2, namespace, {
		NoSpin = true,
	})
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type		= "submenu",
		name		= GetString(PP_LAM_SCENE_INV),
		controls	= {
			{	type			= "checkbox",
				name			= GetString(PP_LAM_SCENE_INV_NO_SPIN),
				-- tooltip			= GetString(PP_LAM_SCENE_INV_NO_SPIN_TT),
				getFunc			= function() return sv.NoSpin end,
				setFunc			= function(value) sv.NoSpin = value end,
				default			= def.NoSpin,
				requiresReload	= true,
			 },
		 },
	})
	--===============================================================================================--
	local tlcs = {
		{ ZO_PlayerInventory, 'inventory' }, { ZO_CraftBag }, { ZO_InventoryWallet }, { ZO_QuestItems }, { ZO_QuickSlot_Keyboard_TopLevel },
		{ ZO_PlayerBank, 'bank' }, { ZO_HouseBank, 'houseBank' }, { ZO_GuildBank, 'guildBank' },
		{ ZO_StoreWindow, 'store' }, { ZO_BuyBack }, { ZO_RepairWindow },
		{ ZO_StablePanel, 'stables' },
		{ ZO_Trade, 'trade' },
		{ ZO_FurnitureVault, "furnitureVault" },
		{ false, 'fence_keyboard' }
	}

	local l_tabs = PP:GetLayout('menuBar', 'tabs')
	local l_menu = PP:GetLayout('menuBar', 'menu')

	for i = 1, #tlcs do
		local control, scene  = tlcs[i][1], tlcs[i][2]
		local l_inventory = PP:GetLayout('inventory', control)
		
		if control then
			local tlc, list, sortBy, tabs, filterDivider, searchFilters, searchDivider, infoBar, menu = PP.GetLinks(control, l_inventory)
			menu = l_inventory.options.menu or menu

			PP:CreateBackground(tlc,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
			PP.Anchor(tlc,					--[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, l_inventory.tlc.t_y, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, l_inventory.tlc.b_y)

			if list then
				PP:RefreshStyle_InventoryList(list)
				PP.ScrollBar(list)
				PP.Anchor(list,				--[[#1]] TOPRIGHT, tlc, TOPRIGHT, 0, l_inventory.list.t_y, --[[#2]] true, BOTTOMRIGHT, tlc, BOTTOMRIGHT, 0, l_inventory.list.b_y)
				list:SetWidth(l_inventory.list.w)
			end
			if sortBy then
				PP.Anchor(sortBy,			--[[#1]] BOTTOM, list, TOP, 0, 0)
				local sortByName = sortBy:GetNamedChild("Name")
				sortByName:SetWidth(l_inventory.sort.name_w)
				sortByName:SetAnchorOffsets(l_inventory.sort.name_t_x, nil, 1)
			end
			local emptyLabel = tlc:GetNamedChild("Empty")
			if emptyLabel then
				PP.Anchor(emptyLabel,		--[[#1]] TOPLEFT, tlc, TOPLEFT, 50, 200, --[[#2]] true, TOPRIGHT, tlc, TOPRIGHT, -50, 200)
			end
			if tabs then
				PP.Anchor(tabs,				--[[#1]] TOPRIGHT, tlc, TOPRIGHT, -20, 10)
				tabs:SetHidden(l_inventory.options.noTabs)
				PP:RefreshStyle_MenuBar(tabs, l_tabs)
			end
			if filterDivider then
				PP.Anchor(filterDivider,	--[[#1]] TOP, tlc, TOP, 0, 52)
				filterDivider:SetHidden(l_inventory.options.noFDivider)
			end
			if searchFilters then
				PP.Anchor(searchFilters,	--[[#1]] TOPRIGHT, tlc, TOPRIGHT, -20, 60)
			end
			if searchDivider then
				PP.Anchor(searchDivider,	--[[#1]] TOP, tlc, TOP, 0, 98)
			end
			if menu then
				PP.Anchor(menu,				--[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
				PP:RefreshStyle_MenuBar(menu, l_menu)
			end
			if infoBar then
				PP:RefreshStyle_InfoBar(infoBar, l_inventory)
			end
		end

		if scene then
			local s		= SCENE_MANAGER:GetScene(scene)
			local a_f	= l_inventory.fragments.add
			local r_f	= l_inventory.fragments.remove
			local h_bg	= l_inventory.fragments.hideBgForScene
			
			for j = 1, #a_f do
				s:AddFragment(a_f[j])
			end
			for k = 1, #r_f do
				s:RemoveFragment(r_f[k])
			end
			for l = 1, #h_bg do
				PP:HideBackgroundForScene(SCENE_MANAGER:GetScene(scene), h_bg[l].PP_BG)
			end
		end
	end
	---------------------------------------------------------------------------------------------------
	-- CHARACTER_WINDOW_STATS_FRAGMENT
	ZO_Character:SetAnchorOffsets(0, -28, 2)
	PP:CreateBackground(ZO_Character,		--[[#1]] nil, nil, nil, 0, 16, --[[#2]] nil, ZO_CharacterWindowStats, nil, -2, 30)
	ZO_CharacterWindowStats:SetWidth(30)
	ZO_PreHookHandler(ZO_CharacterWindowStats, 'OnEffectivelyShown', function(self, hidden) self:SetWidth(303) end)
	ZO_PreHookHandler(ZO_CharacterWindowStats, 'OnEffectivelyHidden', function(self, hidden) self:SetWidth(30) end)
	---------------------------------------------------------------------------------------------------
	if sv.NoSpin then
		TREASURE_MAP_INVENTORY_SCENE:RemoveFragment(FRAME_TARGET_CENTERED_FRAGMENT)
		TREASURE_MAP_INVENTORY_SCENE:RemoveFragment(FRAME_PLAYER_FRAGMENT)

		local inventoryScene = SCENE_MANAGER:GetScene('inventory')
		PP.RemoveFragmentFromSceneAndKeepPreviewFunctionality(inventoryScene, FRAME_PLAYER_FRAGMENT, {"PreviewInventoryItem"}, nil)
		--[[

		inventoryScene:RemoveFragment(FRAME_PLAYER_FRAGMENT)

		local itemPreview						= SYSTEMS:GetObject("itemPreview")
		local ex_PreviewInventoryItem			= itemPreview.PreviewInventoryItem
		local ex_IsCharacterPreviewingAvailable = IsCharacterPreviewingAvailable

		local function callback_EndCurrentPreview()
			itemPreview:UnregisterCallback("EndCurrentPreview", callback_EndCurrentPreview)
			inventoryScene:RemoveFragment(FRAME_PLAYER_FRAGMENT)
		end

		local function new_PreviewInventoryItem(...)
			inventoryScene:AddFragment(FRAME_PLAYER_FRAGMENT)
			itemPreview:RegisterCallback("EndCurrentPreview", callback_EndCurrentPreview)
			return ex_PreviewInventoryItem(...)
		end

		local function new_IsCharacterPreviewingAvailable(...)
			return true
		end

		inventoryScene:RegisterCallback("StateChange", function(oldState, newState)
			if newState == SCENE_SHOWING then
				IsCharacterPreviewingAvailable		= new_IsCharacterPreviewingAvailable
				itemPreview.PreviewInventoryItem	= new_PreviewInventoryItem
			elseif newState == SCENE_HIDDEN then
				IsCharacterPreviewingAvailable		= ex_IsCharacterPreviewingAvailable
				itemPreview.PreviewInventoryItem	= ex_PreviewInventoryItem
			end
		end)
		]]
	end

	--SCENE_MANAGER:GetScene("stables")
	local tabStablesBar = {ZO_StablePanelSpeedTrainRowBarContainer, ZO_StablePanelStaminaTrainRowBarContainer, ZO_StablePanelCarryTrainRowBarContainer}
	for _, bar in pairs(tabStablesBar) do
		PP.Bar(bar:GetNamedChild("StatusBarBar"), --[[height]] 8, --[[fontSize]] 15)
		bar:GetNamedChild("StatusBar"):SetHeight(16)
		PP.Font(bar:GetNamedChild("Value"), --[[Font]] PP.f.u67, 24, "outline")
	end

	--FENCE_KEYBOARD -> SI_FENCE_HAGGLING_SKILL_BONUS_LABEL
	--Set the fence haggling bonus text to a short <number>% only
	ZO_PreHook(FENCE_KEYBOARD, "UpdateHagglingLabel", function(selfVar, skillLevel)
		if skillLevel > 0 then
			ZO_PlayerInventoryInfoBarAltMoney:SetText(zo_strformat("|cEECA2A<<1>>|r%", skillLevel))
			ZO_PlayerInventoryInfoBarAltMoney:SetHidden(false)
		else
			ZO_PlayerInventoryInfoBarAltMoney:SetHidden(true)
		end
		return true --prevent original function call
	end)

	ZO_PreHook("ZO_InventorySlot_SetHighlightHidden", function(listPart, hidden, instant)
		if listPart and listPart.backdrop then
			if hidden then
				listPart.backdrop:SetCenterColor(unpack(PP.savedVars.ListStyle.list_skin_backdrop_col))
			else
				listPart.backdrop:SetCenterColor(unpack(PP.savedVars.ListStyle.list_skin_backdrop_hl_col))
			end
			return true
		end
	end)
	ZO_PreHook("ZO_InventorySlot_SetControlScaledUp", function(control, scaledUp, instant)
		return true
	end)

	-- ZO_InventorySlot_Status_OnMouseEnter
	function ZO_InventoryMenuBar:LayoutCraftBagTooltip(tooltip)
		local str	= HasCraftBagAccess() and SI_ESO_PLUS_STATUS_UNLOCKED or SI_ESO_PLUS_STATUS_LOCKED
		local title	= zo_strformat(SI_INVENTORY_CRAFT_BAG_STATUS, ZO_DEFAULT_ENABLED_COLOR:Colorize(GetString(str)))
		SetTooltipText(tooltip, title)
	end

	function ZO_InventoryManager:ApplySharedBagLayout(...) end
end