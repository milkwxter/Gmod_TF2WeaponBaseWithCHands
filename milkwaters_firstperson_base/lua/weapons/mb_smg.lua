if SERVER then AddCSLuaFile() end

SWEP.Base = "weapon_tf2milkbase"

SWEP.PrintName = "SMG"
SWEP.Purpose = "A standard SMG."
SWEP.Category = "TF2 SWEPs"
SWEP.SubCatType = { "Sniper" }
SWEP.Spawnable = true
SWEP.IconOverride = "weapons/mb_smg.png"
SWEP.Slot = 2

SWEP.ViewModel = "models/smg/v_smg_sniper.mdl"
SWEP.WorldModel = "models/weapons/c_models/c_smg/c_smg.mdl"

SWEP.HandOffset_Pos = Vector(3, -1, -1) -- forward, right, up
SWEP.HandOffset_Ang = Angle(0, 0, 180) -- pitch, yaw, roll

SWEP.MuzzleOffset_Pos = Vector(25, 0, 3) -- forward, right, up
SWEP.MuzzleOffset_Ang = Angle(0, 0, 0) -- pitch, yaw, roll
SWEP.MuzzleEffect = "muzzle_smg"

SWEP.SoundShootPrimary = "weapons/pistol_shoot.wav"
SWEP.HoldType = "smg"
SWEP.Casing = "ShellEject"

SWEP.Primary.ClipSize = 25
SWEP.Primary.DefaultClip = 25
SWEP.Primary.Ammo = "SMG1"

SWEP.Primary.Automatic = true
SWEP.Primary.FireDelay = 0.105
SWEP.Primary.Damage = 8
SWEP.Primary.NumShots = 1
SWEP.Cone = 0.02
SWEP.Primary.Recoil = 2