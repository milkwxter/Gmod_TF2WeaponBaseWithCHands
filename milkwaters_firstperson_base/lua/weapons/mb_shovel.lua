if SERVER then AddCSLuaFile() end

SWEP.Base = "weapon_tf2milkbase"

SWEP.PrintName = "Shovel"
SWEP.Purpose = "A standard shovel."
SWEP.Category = "TF2 SWEPs"
SWEP.SubCatType = { "Soldier" }
SWEP.Spawnable = true
SWEP.IconOverride = "weapons/mb_shovel.png"

SWEP.ViewModel = "models/v_shovel_soldier.mdl"
SWEP.WorldModel = "models/weapons/c_models/c_shovel/c_shovel.mdl"

SWEP.HandOffset_Pos = Vector(3, -1, -1) -- forward, right, up
SWEP.HandOffset_Ang = Angle(0, 0, 180) -- pitch, yaw, roll

SWEP.MuzzleOffset_Pos = Vector(20, -1, 4) -- forward, right, up
SWEP.MuzzleOffset_Ang = Angle(0, 0, 0) -- pitch, yaw, roll
SWEP.MuzzleEffect = ""

SWEP.SoundShootPrimary = ""
SWEP.HoldType = "melee"
SWEP.Casing = ""

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