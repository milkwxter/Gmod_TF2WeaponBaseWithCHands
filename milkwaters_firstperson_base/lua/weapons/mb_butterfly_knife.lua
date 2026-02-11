if SERVER then AddCSLuaFile() end

SWEP.Base = "weapon_tf2milkbase"

SWEP.PrintName = "Butterfly Knife"
SWEP.Purpose = "Backstab for crits!"
SWEP.Category = "TF2 SWEPs"
SWEP.SubCatType = { "Spy" }
SWEP.Spawnable = true
SWEP.IconOverride = "weapons/mb_butterfly_knife.png"

SWEP.ViewModel = "models/knife/v_knife_spy.mdl"
SWEP.WorldModel = "models/weapons/c_models/c_knife/c_knife.mdl"

SWEP.HandOffset_Pos = Vector(3, -1, -2) -- forward, right, up
SWEP.HandOffset_Ang = Angle(0, 0, 180) -- pitch, yaw, roll

SWEP.MuzzleOffset_Pos = Vector(20, -1, 4) -- forward, right, up
SWEP.MuzzleOffset_Ang = Angle(0, 0, 0) -- pitch, yaw, roll
SWEP.MuzzleEffect = ""

SWEP.SoundShootPrimary = ""
SWEP.HoldType = "knife"
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
SWEP.MeleeDamage = 40
SWEP.MeleeRange = 70
SWEP.MeleeDelay = 0.2

function SWEP:IsBackstab(target)
    if not IsValid(target) then return false end
    if not (target:IsPlayer() or target:IsNPC()) then return false end

    local att = self:GetOwner()
    local attackerForward = att:GetAimVector()
    local victimForward   = target:GetAimVector()

    local dot = attackerForward:Dot(victimForward)
    return dot > 0.5
end

function SWEP:DoMeleeAttack()
    local owner = self:GetOwner()
    if not IsValid(owner) then return end
	
	local tr = owner:GetEyeTrace()
	local isBackstab = self:IsBackstab(tr.Entity)

    -- play swing effects
    owner:EmitSound(self.MeleeSwingSound)
	owner:SetAnimation(PLAYER_ATTACK1)
	if isBackstab then
		self:SendWeaponAnim(ACT_VM_SWINGHARD)
	else
		self:SendWeaponAnim(self.PrimaryAnim)
	end

    timer.Simple(self.MeleeDelay, function()
        if not IsValid(self) or not IsValid(owner) then return end
        self:DoMeleeTrace()
    end)
end

-- full crits if you got a back stab
function SWEP:ModifyDamage(att, tr, dmginfo)
    -- get base damage + base crits
    local dmg, isMiniCrit, isFullCrit = self.BaseClass.ModifyDamage(self, att, tr, dmginfo)

    local hit = tr.Entity
    if not IsValid(hit) then
        return dmg, isMiniCrit, isFullCrit
    end

    if hit:IsPlayer() or hit:IsNPC() then
		local isBackstab = self:IsBackstab(tr.Entity)
		
		if isBackstab then
			isFullCrit = true
			dmg = 150
		end
	end

    return dmg, isMiniCrit, isFullCrit
end