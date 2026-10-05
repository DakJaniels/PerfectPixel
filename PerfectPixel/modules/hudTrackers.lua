local PP = PP ---@class PP

PP.hudTrackers = function()
	local PROGRESS_LABEL_OFFSET_Y = 1

	local function restoreGamepadProgressBar(progressBar)
		-- Backdrop only exists once PP.Bar has styled the bar in keyboard mode.
		local backdrop = progressBar:GetNamedChild("Backdrop")
		if backdrop then backdrop:SetHidden(true) end
		progressBar:GetNamedChild("BG"):SetHidden(false)
		progressBar:GetNamedChild("Overlay"):SetHidden(false)
		progressBar:EnableLeadingEdge(true)
		progressBar:GetNamedChild("Gloss"):EnableLeadingEdge(true)
	end

	-- Must run after ZO_ApplyPlatformTemplateToControl(bar, "ZO_HUDTracker_Base_ProgressBar"), which resets textures and size.
	local function applyProgressBarStyle(progressBar)
		if IsInGamepadPreferredMode() then
			restoreGamepadProgressBar(progressBar)
			return
		end
		PP.Bar(progressBar, --[[height]] 14, --[[fontSize]] 15)
		progressBar:GetNamedChild("Backdrop"):SetHidden(false)
		local progressLabel = progressBar:GetNamedChild("Progress")
		progressLabel:ClearAnchors()
		progressLabel:SetAnchor(CENTER, progressBar, CENTER, 0, PROGRESS_LABEL_OFFSET_Y)
	end

	SecurePostHook(TIMED_ACTIVITY_TRACKER, "ApplyPlatformStyle", function(self)
		applyProgressBarStyle(self.progressBar)
	end)

	SecurePostHook(DYNAMIC_EVENTS_TRACKER, "ApplyPlatformStyle", function(self)
		applyProgressBarStyle(self.progressBar)
	end)

	SecurePostHook(ACHIEVEMENT_TRACKER, "ApplyPlatformStyle", function(self)
		for _, criteriaProgressBar in self.criteriaProgressPool:ActiveAndFreeObjectIterator() do
			applyProgressBarStyle(criteriaProgressBar)
		end
	end)

	local criteriaProgressPool = ACHIEVEMENT_TRACKER.criteriaProgressPool
	local zosCriteriaProgressFactoryBehavior = criteriaProgressPool.customFactoryBehavior
	criteriaProgressPool:SetCustomFactoryBehavior(function(criteriaProgressBar, ...)
		zosCriteriaProgressFactoryBehavior(criteriaProgressBar, ...)
		applyProgressBarStyle(criteriaProgressBar)
	end)
end
