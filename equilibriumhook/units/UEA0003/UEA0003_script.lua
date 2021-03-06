-----------------------------------------------------------------
-- File     :  /cdimage/units/UEA0003/UEA0003_script.lua
-- Summary  :  UEF sACU Pod Script
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-----------------------------------------------------------------

local TConstructionUnit = import('/lua/terranunits.lua').TConstructionUnit
local EffectUtilities = import('/lua/EffectUtilities.lua')

local oldUEA0003 = UEA0003

UEA0003 = Class(oldUEA0003) {
    UpdateBuildRate = function(self, parenttechlevel)
        -- change the build rate of the pod based on the acus tech level upgrades.
        -- the acu script calls it on tech upgrade on drone build and rebuild
        local buildRates = {5,10,20}
        self:SetBuildRate(buildRates[parenttechlevel])
        
        self.MakeUpgFx = self:ForkThread(self.CreateUpgradeEffects)
    end,
    
    CreateUpgradeEffects = function(self) --shows that shits going down with the drone as well.
        local effects = TrashBag()
        EffectUtilities.CreateEnhancementEffectAtBone(self, 0, effects )
        EffectUtilities.CreateEnhancementUnitAmbient(self, 0, effects )
        local scale = 0.5
        for _, e in effects do
            e:ScaleEmitter(scale)
            self.UpgradeEffectsBag:Add(e)
        end
        WaitSeconds(1)
        if self.UpgradeEffectsBag then
            self.UpgradeEffectsBag:Destroy()
        end
    end,
}

TypeClass = UEA0003
