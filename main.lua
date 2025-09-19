-- GreenAlienHead
-- Xaidee
mods["RoRRModdingToolkit-RoRR_Modding_Toolkit"].auto(true)

local PATH = _ENV["!plugins_mod_folder_path"]

local DEBUG = true

-- Predefine here so we can make it configurable at a later date.
local alienHeadCdr = 0.15

local debug_print = function(string)
	if DEBUG then print(string) end
end

local init = function()
	debug_print("Attempting to modify ror-alienHead")
	local alienHead = Item.find("ror", "alienHead")
	gm.sprite_replace(gm.constants.sAlienHead, path.combine(PATH, "greenAlienHead.png"), 1, false, false, 16, 16)
	debug_print("Successfully replaced sprite")
	alienHead:set_tier(Item.TIER.uncommon)
	debug_print("Successfully modified item tier")
	alienHead:clear_callbacks()
	alienHead:onStatRecalc(function(actor, stack)
		debug_print("Adjusting ror-alienHead cdr...")
		debug_print("Current cdr of: "..actor.cdr.." (Vanilla behavior)")
		-- Cancel out base-game's cdr
		local vanilla_mult = 1 - (1 - 0.3) ^ stack
		actor.cdr = actor.cdr - vanilla_mult
		debug_print("Current cdr of: "..actor.cdr..". Should be zero if no other item/statRecalc is changing cdr")
		-- Add our own cdr
		local new_mult = 1 - (1 - alienHeadCdr) ^ stack
		actor.cdr = actor.cdr + new_mult
		debug_print("Modified cdr to: "..actor.cdr.." with "..stack.." stacks of Alien Head")
	end)
	debug_print("Successfully modified onStatRecalc")
end
Initialize(init)

