if SERVER then AddCSLuaFile() end

SWEP.Base = "weapon_tf2milkbase"

SWEP.PrintName = "Boxing Gloves"
SWEP.Purpose = "Standard boxing gloves."
SWEP.Category = "TF2 SWEPs"
SWEP.SubCatType = { "Heavy" }
SWEP.Spawnable = true
SWEP.IconOverride = "weapons/mb_boxing_gloves.png"

SWEP.ViewModel = "models/boxinggloves/v_boxing_gloves_heavy.mdl"
SWEP.WorldModel = "models/boxinggloves/c_boxing_gloves.mdl"
SWEP.BoneMergeWorldModel = true

SWEP.HandOffset_Pos = Vector(3, -1, -1) -- forward, right, up
SWEP.HandOffset_Ang = Angle(0, 0, 180) -- pitch, yaw, roll

SWEP.MuzzleOffset_Pos = Vector(20, -1, 4) -- forward, right, up
SWEP.MuzzleOffset_Ang = Angle(0, 0, 0) -- pitch, yaw, roll
SWEP.MuzzleEffect = ""

SWEP.SoundShootPrimary = ""
SWEP.HoldType = "fist"
SWEP.Casing = ""

SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Ammo = "none"
SWEP.PrimaryAnim = ACT_VM_HITRIGHT

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

-- just randomize the attacks
function SWEP:PrimaryAttack()
    -- pick either left or right swing
    local anim = math.random(0, 1) == 0 and ACT_VM_HITLEFT or ACT_VM_HITRIGHT
	self.PrimaryAnim = anim

    -- now do the actual attack logic
    self.BaseClass.PrimaryAttack(self)
end