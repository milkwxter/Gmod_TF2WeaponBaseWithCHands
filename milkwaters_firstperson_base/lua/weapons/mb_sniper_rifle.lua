if SERVER then AddCSLuaFile() end

SWEP.Base = "weapon_tf2milkbase"

SWEP.PrintName = "Sniper Rifle"
SWEP.Purpose = "A standard sniper rifle."
SWEP.Category = "TF2 SWEPs"
SWEP.SubCatType = { "Sniper" }
SWEP.Spawnable = true
SWEP.IconOverride = "weapons/mb_sniper_rifle.png"
SWEP.Slot = 3

SWEP.ViewModel = "models/sniperrifle/v_sniperrifle_sniper.mdl"
SWEP.WorldModel = "models/weapons/c_models/c_sniperrifle/c_sniperrifle.mdl"

SWEP.HandOffset_Pos = Vector(7, 0, -2) -- forward, right, up
SWEP.HandOffset_Ang = Angle(0, 0, 180) -- pitch, yaw, roll

SWEP.MuzzleOffset_Pos = Vector(20, -1, 4) -- forward, right, up
SWEP.MuzzleOffset_Ang = Angle(0, 0, 0) -- pitch, yaw, roll
SWEP.MuzzleEffect = "muzzle_smg"

SWEP.SoundShootPrimary = "weapons/sniper_shoot.wav"
SWEP.HoldType = "ar2"
SWEP.Casing = "ShellEject"

SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Ammo = "357"
SWEP.AutoReload = true

SWEP.Primary.Automatic = true
SWEP.Primary.FireDelay = 1.5
SWEP.Primary.Damage = 50
SWEP.Primary.NumShots = 1
SWEP.Cone = 0
SWEP.Primary.Recoil = 10

SWEP.CanZoom = true
SWEP.Zoomed = false
SWEP.ZoomFOV = 20
SWEP.ZoomCharge = true
SWEP.ZoomDot = "effects/sniperdot"

-- full crits if you got a head shot while zoomed
function SWEP:ModifyDamage(att, tr, dmginfo)
    -- get base damage + base crits
    local dmg, isMiniCrit, isFullCrit = self.BaseClass.ModifyDamage(self, att, tr, dmginfo)

	if self:GetZoomed() then
		local hit = tr.Entity
		if not IsValid(hit) then
			return dmg, isMiniCrit, isFullCrit
		end

		-- headshot
		if tr.HitGroup == HITGROUP_HEAD and (hit:IsNPC() or hit:IsPlayer()) then
			isFullCrit = true
		end
		
		-- multiply by charge progress times three
		local frac = math.Clamp(self:GetZoomChargeProgress(), 0, 1)
		dmg = self.Primary.Damage + frac * (150 - self.Primary.Damage)
	end

    return dmg, isMiniCrit, isFullCrit
end