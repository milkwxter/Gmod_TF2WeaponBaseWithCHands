if SERVER then
	AddCSLuaFile()
end

-- cache my particles
game.AddParticles("particles/flamethrower.pcf")
PrecacheParticleSystem("_flamethrower_REAL")

SWEP.Base = "weapon_tf2milkbase"

SWEP.PrintName = "Flamethrower"
SWEP.Purpose = "A standard flamethrower."
SWEP.Category = "TF2 SWEPs"
SWEP.SubCatType = { "Pyro" }
SWEP.Spawnable = true
SWEP.IconOverride = "weapons/mb_flamethrower.png"
SWEP.Slot = 4

SWEP.ViewModel = "models/flamethrower/v_flamethrower_pyro.mdl"
SWEP.WorldModel = "models/weapons/c_models/c_flamethrower/c_flamethrower.mdl"
SWEP.PlayAttackAnim = false

SWEP.HandOffset_Pos = Vector(0, 0, 0) -- forward, right, up
SWEP.HandOffset_Ang = Angle(10, 0, 180) -- pitch, yaw, roll

SWEP.MuzzleOffset_Pos = Vector(70, 0, 1) -- forward, right, up
SWEP.MuzzleOffset_Ang = Angle(0, 0, 0) -- pitch, yaw, roll
SWEP.MuzzleEffectStaysWhileFiring = true
SWEP.MuzzleEffect = "_flamethrower_REAL"

SWEP.LoopShootingSound = true
SWEP.SoundShootPrimary = "weapons/flame_thrower_start.wav"
SWEP.SoundShootLoop = "weapons/flame_thrower_loop.wav"
SWEP.SoundShootEnd = "weapons/flame_thrower_end.wav"

SWEP.HoldType = "crossbow"
SWEP.Caseless = true

SWEP.Primary.ClipSize = 200
SWEP.Primary.DefaultClip = 200
SWEP.Primary.Ammo = "Pistol"

SWEP.Projectile = true
SWEP.ProjectileClass = "mb_fire_proj"
SWEP.ProjectileSpeed = 1500
SWEP.ProjectileGravity = false

SWEP.Primary.Automatic = true
SWEP.Primary.FireDelay = 0.06
SWEP.Primary.Damage = 7
SWEP.Primary.NumShots = 3
SWEP.Cone = 5
SWEP.Primary.Recoil = 0