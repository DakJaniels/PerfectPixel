PP.compatibility = function ()
local PP         = PP
local tinsert    = table.insert

	local function Compatibility()
		--==LibCustomMenu==--
		if LibCustomMenu then
			local lcmSM               = LibCustomMenuSubmenu
			local lcmSMBG             = GetControl(lcmSM, "BG")
			local lcmSMBGMungeOverlay = GetControl(lcmSMBG, "MungeOverlay")
			local lcmSMHighlight      = GetControl(lcmSM, "Highlight")

			ZO_PreHookHandler(LibCustomMenuSubmenu, "OnShow", function ()
				lcmSMBG:SetCenterTexture(nil, 4, 0)
				lcmSMBG:SetCenterColor(10 / 255, 10 / 255, 10 / 255, 0.96)
				lcmSMBG:SetEdgeTexture(nil, 1, 1, 1, 0)
				lcmSMBG:SetEdgeColor(60 / 255, 60 / 255, 60 / 255, 1)
				lcmSMBG:SetInsets(-1, -1, 1, 1)
				if lcmSMBGMungeOverlay then lcmSMBGMungeOverlay:SetHidden(true) end
			end)

			PP.Anchor(lcmSMBG, --[[#1]] TOPLEFT, nil, TOPLEFT, -2, 4, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -2, -4)
			-- lcmSMBG:SetInheritAlpha(false)

			if lcmSMHighlight then
				lcmSMHighlight:SetCenterTexture(nil, 4, 0)
				lcmSMHighlight:SetCenterColor(96 / 255 * 0.3, 125 / 255 * 0.3, 139 / 255 * 0.3, 1)
				lcmSMHighlight:SetEdgeTexture(nil, 1, 1, 1, 0)
				lcmSMHighlight:SetEdgeColor(96 / 255 * 0.5, 125 / 255 * 0.5, 139 / 255 * 0.5, 0)
				lcmSMHighlight:SetInsets(0, 0, 0, 0)
				-- lcmSMHighlight:SetInheritAlpha(false)
			end
		end
		--===============================================================================================--

		--==CraftBagExtended==--
		if CraftBagExtended then
			CraftBagExtendedVendorMenu:SetParent(ZO_StoreWindowMenu)
			PP.Anchor(CraftBagExtendedVendorMenu, --[[#1]] TOPLEFT, ZO_StoreWindowMenu, TOPLEFT, 80, 0)

			CraftBagExtendedHouseBankMenu:SetParent(ZO_HouseBankMenu)
			PP.Anchor(CraftBagExtendedHouseBankMenu, --[[#1]] TOPLEFT, ZO_HouseBankMenu, TOPLEFT, 80, 0)

			CraftBagExtendedBankMenu:SetParent(ZO_PlayerBankMenu)
			PP.Anchor(CraftBagExtendedBankMenu, --[[#1]] TOPLEFT, ZO_PlayerBankMenu, TOPLEFT, 80, 0)

			CraftBagExtendedGuildBankMenu:SetParent(ZO_GuildBankMenu)
			PP.Anchor(CraftBagExtendedGuildBankMenu, --[[#1]] TOPLEFT, ZO_GuildBankMenu, TOPLEFT, 80, 0)

			CraftBagExtendedMailMenu:SetParent(ZO_MailSend)
			PP.Anchor(CraftBagExtendedMailMenu, --[[#1]] TOPLEFT, ZO_MailSend, TOPLEFT, 420, -55)

			-- CraftBagExtendedTradeMenu:SetParent(parent)
			-- PP.Anchor(CraftBagExtendedTradeMenu,		--[[#1]] TOPLEFT, parent,		TOPLEFT, 80, 0)
		end
		--===============================================================================================--

		--==AddonSelector==--
		if AddonSelector then
			PP.Anchor(ZO_AddOnsList, --[[#1]] TOPLEFT, AddonSelector, BOTTOMLEFT, 0, 5, --[[#2]] true, BOTTOMRIGHT, ZO_AddOns, BOTTOMRIGHT, 0, -10)
			PP.Anchor(AddonSelectorBottomDivider, --[[#1]] BOTTOM, AddonSelector, BOTTOM, 40, 0)
			PP.Anchor(AddonSelectorSearchBox, --[[#1]] TOPRIGHT, ZO_AddOns, TOPRIGHT, -6, 6)
			if AddonSelectorAutoReloadUI and AddonSelectorAutoReloadUILabel then
				PP.Anchor(AddonSelectorAutoReloadUILabel, --[[#1]] TOPRIGHT, AddonSelectorSearchBox, BOTTOMRIGHT, 0, 6)
				PP.Anchor(AddonSelectorAutoReloadUI, --[[#1]] RIGHT, AddonSelectorAutoReloadUILabel, LEFT, -6, 0)
			end
			PP.Font(AddonSelectorDeselectAddonsButtonKeyLabel, --[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
			PP.Font(AddonSelectorDeselectAddonsButtonNameLabel, --[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
			PP.Font(AddonSelectorSelectAddonsButtonKeyLabel, --[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
			PP.Font(AddonSelectorSelectAddonsButtonNameLabel, --[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
		end
		--===============================================================================================--

		--==MailLooter==--
		if MailLooter then
			MAIL_LOOTER_SCENE:RemoveFragment(TITLE_FRAGMENT)
			MAIL_LOOTER_SCENE:RemoveFragment(MAIL_TITLE_FRAGMENT)
			MAIL_LOOTER_SCENE:RemoveFragment(FRAME_PLAYER_FRAGMENT)
			PP.Anchor(MailLooterLootList, --[[#1]] TOP, MailLooterLootHeaders, BOTTOM, 0, 0, --[[#2]] true, BOTTOMRIGHT, ZO_MailInbox, BOTTOMRIGHT, 0, -100)
		end
		--===============================================================================================--

		--==ESO Master Recipe List==--
		if ESOMRL then
			local resultTooltip = PROVISIONER.resultTooltip
			PP:SetLockFn(resultTooltip, "SetAnchor")
			PP:SetLockFn(resultTooltip, "ClearAnchors")
		end
		--===============================================================================================--

		--==Potion Maker==--
		if PotMaker then
			PP.Anchor(ZO_AlchemyTopLevelContent, --[[#1]] TOPRIGHT, ZO_AlchemyTopLevel, TOPRIGHT, 0, 100, --[[#2]] true, BOTTOMRIGHT, ZO_AlchemyTopLevel, BOTTOMRIGHT, 0, -80)
			ZO_AlchemyTopLevelContent:SetWidth(565)
			PP:CreateBackground(ZO_AlchemyTopLevelPotionMaker, --[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
			PP:CreateBackground(ZO_AlchemyTopLevelPoisonMaker, --[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
		end
		--===============================================================================================--

		--==VotansMiniMap==--
		if VOTANS_MINIMAP then
			WORLD_MAP_SCENE:RegisterCallback("StateChange", function (oldState, newState)
				if newState == SCENE_SHOWN then
					WORLD_MAP_FRAGMENT.duration = PP.fade_scene_duration
				end
			end)

			if PP.savedVars.Compass.toggle then
				ZO_CompassFrameLeft:SetHidden(true)
				ZO_CompassFrameRight:SetHidden(true)
				ZO_CompassFrameCenter:SetHidden(true)
				PP:SetLockFn(ZO_CompassFrameLeft, "SetHidden")
				PP:SetLockFn(ZO_CompassFrameRight, "SetHidden")
				PP:SetLockFn(ZO_CompassFrameCenter, "SetHidden")
			end
		end
		--===============================================================================================--

		--==InventoryInsightFromAshes==--
		if IIFA_GUI then
			PP:CreateBackground(IIFA_GUI_BG, --[[#1]] nil, nil, nil, 6, 6, --[[#2]] nil, nil, nil, -6, -6)
			PP.ScrollBar(IIFA_GUI_ListHolder_Slider)
			PP.Anchor(IIFA_GUI_ListHolder_Slider, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, 14, 0)
			ZO_Scroll_SetMaxFadeDistance(IIFA_GUI_ListHolder, PP.savedVars.ListStyle.list_fade_distance)
			IIFA_GUI_BGMungeOverlay:SetHidden(true)
		end
		--===============================================================================================--

		--==WizardsWardrobe==--
		if WizardsWardrobe then
			PP.ScrollBar(WizardsWardrobeWindowSetupListScrollBar)
			PP.ScrollBar(WizardsWardrobeArrangeDialogListScrollBar)
			ZO_Scroll_SetMaxFadeDistance(WizardsWardrobeWindowSetupList, PP.savedVars.ListStyle.list_fade_distance)
			ZO_Scroll_SetMaxFadeDistance(WizardsWardrobeArrangeDialogList, PP.savedVars.ListStyle.list_fade_distance)

			PP:CreateBackground(WizardsWardrobeWindowBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
			PP:CreateBackground(WizardsWardrobePrebuffBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
			PP:CreateBackground(WizardsWardrobeCodeDialogBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
			PP:CreateBackground(WizardsWardrobeArrangeDialogBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
			PP:CreateBackground(WizardsWardrobeTransferDialogBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
			PP:CreateBackground(WizardsWardrobePreviewPreviewBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)

			WizardsWardrobeWindowBGMungeOverlay:SetHidden(true)
			WizardsWardrobePrebuffBGMungeOverlay:SetHidden(true)
			WizardsWardrobeCodeDialogBGMungeOverlay:SetHidden(true)
			WizardsWardrobeArrangeDialogBGMungeOverlay:SetHidden(true)
			WizardsWardrobeTransferDialogBGMungeOverlay:SetHidden(true)
			WizardsWardrobePreviewPreviewBGMungeOverlay:SetHidden(true)
		end
		--===============================================================================================--

		--==WPamA==--
		if WPamA then
			PP:CreateBackground(WPamA_WinBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
			WPamA_WinBGMungeOverlay:SetHidden(true)
		end

		--===============================================================================================--

		--==TimWitchesUI==--
		if tim99_WitchesFestival then
			PP:CreateBackground(TimWitchesUIBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
			TimWitchesUIBGMungeOverlay:SetHidden(true)
		end

		--===============================================================================================--

		--==LibSets==--
		if LibSets then
			PP:CreateBackground(LibSets_SearchUI_TLC_KeyboardBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
			PP.ScrollBar(LibSets_SearchUI_TLC_KeyboardContentListScrollBar)
			PP.Anchor(LibSets_SearchUI_TLC_KeyboardContentListScrollBar, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, nil)
			ZO_Scroll_SetMaxFadeDistance(LibSets_SearchUI_TLC_KeyboardContentList, PP.savedVars.ListStyle.list_fade_distance)
		end

		--===============================================================================================--

		--==PortToFriend==--
		if PortToFriend then
			-- PP:CreateBackground(PortToFriend_Body_Backdrop, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
			PortToFriend_Body_BackdropMungeOverlay:SetHidden(true)
		end

		--===============================================================================================--

		--==displayleads==--
		if RDL then
			PP:CreateBackground(RDLMainWindowBG, --[[#1]] nil, nil, nil, 6, 6, --[[#2]] nil, nil, nil, -6, -6)
			PP.ScrollBar(RDLMainWindowListScrollBar)
			PP.Anchor(RDLMainWindowListScrollBar, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, nil)
			ZO_Scroll_SetMaxFadeDistance(RDLMainWindowListContents, PP.savedVars.ListStyle.list_fade_distance)
			RDLMainWindowBGMungeOverlay:SetHidden(true)
		end
		--===============================================================================================--

		--==DebugLogViewer==--
		if DebugLogViewer then
			PP:CreateBackground(DebugLogViewerMainWindowBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
			DebugLogViewerMainWindowBGMungeOverlay:SetHidden(true)
		end
		--===============================================================================================--

		--==WritWorthy==--
		if WritWorthy then
			PP.ScrollBar(WritWorthyUIInventoryListListContents)
			PP.ScrollBar(WritWorthyMatUIListContainerListContents)
			ZO_Scroll_SetMaxFadeDistance(WritWorthyMatUIListContainerListScrollBar, PP.savedVars.ListStyle.list_fade_distance)
			ZO_Scroll_SetMaxFadeDistance(WritWorthyUIInventoryListListScrollBar, PP.savedVars.ListStyle.list_fade_distance)

			PP:CreateBackground(WritWorthyUIBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
			PP:CreateBackground(WritWorthyMatWindowBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)

			WritWorthyMatWindowBGMungeOverlay:SetHidden(true)
			WritWorthyMatUIListContainerListScrollBarThumbMunge:SetHidden(true)
			WritWorthyUIBGMungeOverlay:SetHidden(true)
			WritWorthyUIInventoryListListScrollBarThumbMunge:SetHidden(true)
			WritWorthyUIInventoryListListEmptyRowBG:SetHidden(true)
		end
		--==AwesomeGuildStore==--z
		if AwesomeGuildStore then
			local function AwesomeGuildStore_Compatibility()
				PP.Anchor(AwesomeGuildStoreFooter, nil, nil, nil, nil, 50)
				PP.Anchor(AwesomeGuildStoreActivityStatusLine, nil, nil, nil, nil, -2)
				PP.Anchor(AwesomeGuildStoreGuildSelector, LEFT, ZO_TradingHouseTitle, LEFT, 0, -2)
				PP.Anchor(AwesomeGuildStoreGuildSelectorComboBoxOpenDropdown, LEFT, AwesomeGuildStoreGuildSelectorComboBoxSelectedItemText, RIGHT, 3, 5)
				PP.Font(AwesomeGuildStoreGuildSelectorComboBoxSelectedItemText, PP.f.u67, 30, "outline", 0.9, nil, nil, nil, nil, 0, 0, 0, 0.8)
				PP.ScrollBar(AwesomeGuildStoreFilterArea)
				ZO_Scroll_SetMaxFadeDistance(AwesomeGuildStoreFilterArea, 10)
				PP.ScrollBar(AwesomeGuildStoreActivityWindowContainerListContents)
				ZO_Scroll_SetMaxFadeDistance(AwesomeGuildStoreActivityWindowContainerListScrollBar, 10)

				PP:CreateBackground(AwesomeGuildStoreActivityWindowBG, nil, nil, nil, 0, 0, nil, nil, nil, 0, 0)
				AwesomeGuildStoreActivityWindowBGMungeOverlay:SetHidden(true)


				local function OnUpdateFn(rowControl)
					rowControl:GetNamedChild("SellerName"):SetHidden(true)
				end

				-- Add post hook setup callback to hide seller name
				local list = TRADING_HOUSE.searchResultsList
				PP.PostHooksSetupCallback(list, 1, 1, nil, OnUpdateFn)
				PP.PostHooksSetupCallback(list, 2, 1, nil, OnUpdateFn)
				PP.PostHooksSetupCallback(list, 1, 3, nil, OnUpdateFn)
				PP.PostHooksSetupCallback(list, 2, 3, nil, OnUpdateFn)
			end
			-- Add function to load callback table
			tinsert(PP.LoadFunc_TRADING_HOUSE, AwesomeGuildStore_Compatibility)
		end

		--===============================================================================================--

		-- == ArkadiusTradeTools == --
		if ArkadiusTradeTools then
			local att_tab = {
				bg = {
					ArkadiusTradeToolsWindow,
					ArkadiusTradeToolsWindowBackdrop,
					ArkadiusTradeToolsExportsFrameFilterBarTimeBG,
					ArkadiusTradeToolsExportsFrameToolBarGuildSelectorBG,
				},
				sb = {
					ArkadiusTradeToolsExportsFrameListContents,
					ArkadiusTradeToolsPurchasesFrameListContents,
					ArkadiusTradeToolsSalesFrameListContents,
					ArkadiusTradeToolsStatisticsFrameListContents,
				},
			}

			for i, bg in ipairs(att_tab.bg) do
				PP:CreateBackground(bg, nil, nil, nil, -6, 0, nil, nil, nil, 0, 6)
			end

			for i, sb in ipairs(att_tab.sb) do
				PP.ScrollBar(sb)
			end

			local overlays = {
				ArkadiusTradeToolsExportsFrameFilterBarTimeBGMungeOverlay,
				ArkadiusTradeToolsExportsFrameToolBarGuildSelectorBGMungeOverlay,
				ArkadiusTradeToolsExportsFrameToolBarTimeSelectorBGMungeOverlay,
				ArkadiusTradeToolsPurchasesFrameFilterBarTimeBGMungeOverlay,
				ArkadiusTradeToolsSalesFrameFilterBarTimeBGMungeOverlay,
				ArkadiusTradeToolsStatisticsFrameFilterBarTimeBGMungeOverlay,
				ArkadiusTradeToolsWindowBackdropMungeOverlay,
			}

			for i, overlay in ipairs(overlays) do
				overlay:SetHidden(true)
			end

			PP.Anchor(ZO_TradingHouseBrowseItemsLeftPane, nil, nil, nil, nil, nil, true, nil, nil, nil, nil, -80)
			PP.Anchor(ZO_TradingHouseBrowseItemsLeftPaneCategoryListContainer, nil, nil, nil, nil, nil, true, nil, nil, nil, nil, -10)

			local function OnCreateFn(rowControl, result)
				local name = rowControl:GetNamedChild("Name")
				local timeRemaining = rowControl:GetNamedChild("TimeRemaining")
				local sellPrice = rowControl:GetNamedChild("SellPrice")
				local pricePerUnit = rowControl:GetNamedChild("SellPricePerUnit")

				PP:SetLockFn(name, "SetWidth")
				PP:SetLockFn(timeRemaining, "SetAnchor")
				PP:SetLockFn(timeRemaining, "ClearAnchors")
				PP:SetLockFn(sellPrice, "SetAnchor")
				PP:SetLockFn(sellPrice, "ClearAnchors")
				PP:SetLockFn(pricePerUnit, "SetAnchor")
				PP:SetLockFn(pricePerUnit, "ClearAnchors")
			end

			local function OnUpdateFn(rowControl, result)
				if not rowControl.ATT_Fix then
					local profitMargin = rowControl:GetNamedChild("ProfitMargin")
					local averagePricePerUnit = rowControl:GetNamedChild("AveragePricePerUnit")
					local averagePrice = rowControl:GetNamedChild("AveragePrice")

					if profitMargin then
						PP.Font(profitMargin, PP.f.u67, 15, "shadow", 0.8, nil, nil, nil, nil, 0, 0, 0, 0.5)
						PP.Anchor(profitMargin, nil, nil, nil, 0, 0)
						PP:SetLockFn(profitMargin, "SetFont")

						if averagePrice then
							PP.Font(averagePrice, PP.f.u67, 14, "shadow", 0.8, nil, nil, nil, nil, 0, 0, 0, 0.5)
							PP.Anchor(averagePrice, TOPRIGHT, rowControl, TOPRIGHT, -145, 2)
							PP:SetLockFn(averagePrice, "SetFont")
							PP:SetLockFn(averagePrice, "SetAnchor")
							PP:SetLockFn(averagePrice, "ClearAnchors")
						end

						if averagePricePerUnit then
							PP.Font(averagePricePerUnit, PP.f.u67, 14, "shadow", 0.8, nil, nil, nil, nil, 0, 0, 0, 0.5)
							PP.Anchor(averagePricePerUnit, TOPRIGHT, averagePrice, BOTTOMRIGHT, 0, -2)
							PP:SetLockFn(averagePricePerUnit, "SetFont")
							PP:SetLockFn(averagePricePerUnit, "SetAnchor")
							PP:SetLockFn(averagePricePerUnit, "ClearAnchors")
						end

						rowControl.ATT_Fix = true
					end
				end
			end

			local function ArkadiusTradeTools_Compatibility()
				local list = TRADING_HOUSE.searchResultsList
				PP.PostHooksSetupCallback(list, 1, 1, OnCreateFn, OnUpdateFn)
				PP.PostHooksSetupCallback(list, 2, 1, OnCreateFn, OnUpdateFn)
				PP.PostHooksSetupCallback(list, 1, 3, OnCreateFn, OnUpdateFn)
				PP.PostHooksSetupCallback(list, 2, 3, OnCreateFn, OnUpdateFn)

				if not AwesomeGuildStore then
					PP.Anchor(ZO_TradingHouseBrowseItemsRightPaneSearchSortByTimeRemainingName, RIGHT, ZO_TradingHouseBrowseItemsRightPaneSearchSortByPricePerUnitName, LEFT, -180, 0)
					ZO_TradingHouse:SetWidth(1000)
				end
			end

			tinsert(PP.LoadFunc_TRADING_HOUSE, ArkadiusTradeTools_Compatibility)
		end
		--===============================================================================================--

		--==MasterMerchant==--
		if MasterMerchant then
			local mm_tab = {
				bg = { MasterMerchantWindowBG, MasterMerchantReportsWindowBG, MasterMerchantListingWindowBG, MasterMerchantGuildWindowBG, MasterMerchantPurchaseWindowBG, MasterMerchantStatsWindowBG, MasterMerchantFeedbackBG },
				sb = { MasterMerchantWindowListScrollBar, MasterMerchantReportsWindowListScrollBar, MasterMerchantListingWindowListScrollBar, MasterMerchantGuildWindowListScrollBar, MasterMerchantPurchaseWindowListScrollBar },
			}
			for i = 1, #mm_tab.bg do
				PP:CreateBackground(mm_tab.bg[i], --[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
			end
			for i = 1, #mm_tab.sb do
				PP.ScrollBar(mm_tab.sb[i])
			end

			PP.Anchor(ZO_TradingHouseBrowseItemsLeftPane, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, -50)

			local function OnCreateFn(rowControl, result)
				local timeRemaining = rowControl:GetNamedChild("TimeRemaining")
				local sellPrice     = rowControl:GetNamedChild("SellPrice")
				local pricePerUnit  = rowControl:GetNamedChild("SellPricePerUnit")

				PP:SetLockFn(timeRemaining, "SetAnchor")
				PP:SetLockFn(timeRemaining, "ClearAnchors")
				PP:SetLockFn(sellPrice, "SetAnchor")
				PP:SetLockFn(sellPrice, "ClearAnchors")
				PP:SetLockFn(pricePerUnit, "SetAnchor")
				PP:SetLockFn(pricePerUnit, "ClearAnchors")
			end

			local function OnUpdateFn(rowControl, result, ...)
				if not rowControl.MM_Fix then
					local buyingAdvice = rowControl:GetNamedChild("BuyingAdvice")
					if buyingAdvice then
						PP.Font(buyingAdvice, --[[Font]] PP.f.u67, 14, "shadow", --[[Alpha]] 0.8, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
						PP.Anchor(buyingAdvice, --[[#1]] LEFT, nil, RIGHT, 0, 0)
						PP:SetLockFn(buyingAdvice, "SetFont")
						PP:SetLockFn(buyingAdvice, "SetAnchor")
						PP:SetLockFn(buyingAdvice, "ClearAnchors")
						rowControl.MM_Fix = true
					end
				end
			end

			local function MasterMerchant_Compatibility()
				local list = TRADING_HOUSE.searchResultsList
				PP.PostHooksSetupCallback(list, 1, 1, OnCreateFn)
				PP.PostHooksSetupCallback(list, 2, 1, OnCreateFn)
				PP.PostHooksSetupCallback(list, 1, 3, OnCreateFn)
				PP.PostHooksSetupCallback(list, 2, 3, OnCreateFn)
			end
			tinsert(PP.LoadFunc_TRADING_HOUSE, MasterMerchant_Compatibility)

			ZO_PostHook(MasterMerchant, "AddBuyingAdvice", function (rowControl, result, ...)
				OnUpdateFn(rowControl, result, ...)
			end)
		end
		--===============================================================================================--

		--==pChat==--
		if pChat then
			pChat.ChangeChatWindowDarkness = PP.Dummy
			ZO_PostHook(pChat, "ApplyChatConfig", function (...)
				PP:UpdateBackgrounds("ChatWindow")
			end)
		end
		--===============================================================================================--

		--==LibHistoire==--
		if LibHistoire then
			local wasHistyHooked = false
			SecurePostHook(ZO_GuildHistory_Keyboard, "OnDeferredInitialize", function()
				if not wasHistyHooked then
					local histyGuildHistoryTLC = LibHistoireGuildHistoryStatusWindow
					local histyGuildHistoryTLCBG = histyGuildHistoryTLC:GetNamedChild("Bg")  --LibHistoireGuildHistoryStatusWindowBg
					if histyGuildHistoryTLCBG ~= nil then
						PP:CreateBackground(histyGuildHistoryTLCBG, --[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
					end

					local histyGuildHistoryTLCToggleButton = histyGuildHistoryTLC:GetNamedChild("ToggleButton") --LibHistoireGuildHistoryStatusWindowToggleButton
					if histyGuildHistoryTLCToggleButton ~= nil then
						histyGuildHistoryTLCToggleButton:ClearAnchors()
						histyGuildHistoryTLCToggleButton:SetAnchor(BOTTOMLEFT, ZO_GuildHistory_Keyboard_TL, BOTTOMLEFT, 10, 0)
					end
					wasHistyHooked = true
				end
			end)
		end
		--===============================================================================================--

		--==FCO ChangeStuff==--
		if FCOCS then
			MAIL_SEND_SCENE:RegisterCallback("StateChange", function(oldState, newState)
				if newState == SCENE_SHOWN then
					local mailSettingsGearButton = ZO_MailSend_FCOChangeStuff_FCOCS_MailSettingsContextMenu
					local mailReceiverTriangleButton = ZO_MailSendToLabel_FCOChangeStuff_FCOCS_MailRecipientsContextMenu
					local mailSubjectTriangleButton = ZO_MailSendSubjectLabel_FCOChangeStuff_FCOCS_MailSubjectsContextMenu
					local mailTextTriangleButton = ZO_MailSendBody_FCOChangeStuff_FCOCS_MailTextsContextMenu

					if mailSettingsGearButton ~= nil then
						mailSettingsGearButton:ClearAnchors()
						mailSettingsGearButton:SetAnchor(TOPLEFT, ZO_MailSend, TOPLEFT, -10, -10)
					end
					if mailReceiverTriangleButton ~= nil then
						mailReceiverTriangleButton:ClearAnchors()
						mailReceiverTriangleButton:SetAnchor(LEFT, ZO_MailSendToLabel, RIGHT, 15, 0)
					end
					if mailSubjectTriangleButton ~= nil then
						mailSubjectTriangleButton:ClearAnchors()
						mailSubjectTriangleButton:SetAnchor(LEFT, ZO_MailSendSubjectLabel, RIGHT, 15, 0)
					end
					if mailTextTriangleButton ~= nil then
						mailTextTriangleButton:ClearAnchors()
						mailTextTriangleButton:SetAnchor(TOPLEFT, ZO_MailSendBody, TOPLEFT, -5, -19)
					end
				end
			end)
		end
		--===============================================================================================--



		--UnregisterForEvent--
		EVENT_MANAGER:UnregisterForEvent(PP.ADDON_NAME .. "Compatibility", EVENT_PLAYER_ACTIVATED)
	end

	EVENT_MANAGER:RegisterForEvent(PP.ADDON_NAME .. "Compatibility", EVENT_PLAYER_ACTIVATED, Compatibility)
end
