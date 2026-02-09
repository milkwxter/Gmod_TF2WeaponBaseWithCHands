if SERVER then AddCSLuaFile() end

SWEP.Base = "weapon_tf2milkbase"

SWEP.PrintName = "Bottle"
SWEP.Purpose = "A standard bottle of scrumpy."
SWEP.Category = "TF2 SWEPs"
SWEP.SubCatType = { "Demoman" }
SWEP.Spawnable = true
SWEP.IconOverride = "weapons/mb_bottle.png"

SWEP.ViewModel = "models/bottle/v_bottle_demoman.mdl"
SWEP.WorldModel = "models/weapons/c_models/c_bottle/c_bottle.mdl"

SWEP.HandOffset_Pos = Vector(3, -1, -1) -- forward, right, up
SWEP.HandOffset_Ang = Angle(0, 0, 180) -- pitch, yaw, roll

SWEP.MuzzleOffset_Pos = Vector(0, 0, 0) -- forward, right, up
SWEP.MuzzleOffset_Ang = Angle(0, 0, 0) -- pitch, yaw, roll
SWEP.MuzzleEffect = ""

SWEP.SoundShootPrimary = ""
SWEP.HoldType = "melee"
SWEP.Caseless = true

SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Ammo = "none"
SWEP.PrimaryAnim = ACT_VM_HITCENTER

SWEP.Primary.Automatic = true
SWEP.Primary.FireDelay = 0.8
SWEP.Primary.Damage = 0
SWEP.Primary.NumShots = 1
SWEP.Cone = 0
SWEP.Primary.Recoil = 1

SWEP.Melee = true
SWEP.MeleeDamage = 65
SWEP.MeleeRange = 70
SWEP.MeleeDelay = 0.2

local WorldModelAlt = "models/weapons/c_models/c_bottle/c_bottle_broken.mdl"
local isBrokenBottle = false

function SWEP:ExtraEffectOnHit(att, tr)
	-- bottle breaks
	if SERVER then
		if isBrokenBottle then return end
		
		isBrokenBottle = true
		
		local mdl = self.GetCurrentWorldModel and self:GetCurrentWorldModel() or self.WorldModel
		
		att:EmitSound("weapons/bottle_break.wav")
		self:SetCurrentWorldModel(WorldModelAlt)
		
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			vm:SetBodygroup(1, 1)
		end
	end
end

function SWEP:Deploy()
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) and isBrokenBottle then
        vm:SetBodygroup(1, 1)
    end
    return true
end
