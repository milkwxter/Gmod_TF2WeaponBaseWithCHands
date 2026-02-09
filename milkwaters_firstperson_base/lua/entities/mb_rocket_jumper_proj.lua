if SERVER then
	AddCSLuaFile()
end

-- cache my particles
game.AddParticles( "particles/rockettrail.pcf" )
PrecacheParticleSystem("rockettrail_RocketJumper")

DEFINE_BASECLASS("mb_rocket_proj")

ENT.PrintName = "MW Rocket Jumper"
ENT.TrailEffect = "rockettrail_RocketJumper"