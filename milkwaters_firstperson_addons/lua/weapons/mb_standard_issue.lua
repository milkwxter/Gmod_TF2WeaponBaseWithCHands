if SERVER then AddCSLuaFile() end

SWEP.Base = "weapon_tf2milkbase"

SWEP.PrintName = "Standard Issue"
SWEP.Purpose = "A high capacity pistol."
SWEP.Category = "TF2 SWEPs"
SWEP.SubCatType = { "Scout" }
SWEP.Spawnable = true
SWEP.IconOverride = "weapons/mb_standard_issue.png"
SWEP.Slot = 1

SWEP.ViewModel = "models/weapons/v_models/v_glock_scout.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_glock.mdl"

SWEP.HandOffset_Pos = Vector(5, -1, 1) -- forward, right, up
SWEP.HandOffset_Ang = Angle(0, 0, 180) -- pitch, yaw, roll

SWEP.MuzzleOffset_Pos = Vector(40, -9, -4) -- forward, right, up
SWEP.MuzzleOffset_Ang = Angle(0, 0, 0) -- pitch, yaw, roll
SWEP.MuzzleEffect = "muzzle_smg"

SWEP.SoundShootPrimary = "weapons/glock_fire.wav"
SWEP.HoldType = "pistol"
SWEP.Casing = "ShellEject"

SWEP.Primary.ClipSize = 16
SWEP.Primary.DefaultClip = 16
SWEP.Primary.Ammo = "Pistol"

SWEP.Primary.Automatic = true
SWEP.Primary.FireDelay = 0.17
SWEP.Primary.Damage = 10
SWEP.Primary.NumShots = 1
SWEP.Cone = 0.02
SWEP.Primary.Recoil = 1